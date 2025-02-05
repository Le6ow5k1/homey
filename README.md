## Task

Use Ruby on Rails to build a project conversation history. A user should be able to:

- leave a comment
- change the status of the project

The project conversation history should list comments and changes in status. 

Please don’t spend any more than 3 hours on this task.

## Brief

Treat this as if this was the only information given to you by a team member, and take the approach you would normally take in order to build the right product for the company. 

To this extent:

- Please write down the questions you would have asked your colleagues
- Include answers that you might expect from them
- Then build a project conversation based on the answers to the questions you raised.

## Questions to ask before implementing (with answers):

1. Scope and User Experience
    - Q: What pages and views are needed to display the project conversation history?
    - A: Let's assume that the project creation and managment is already implemented and we only need a page to display the project conversation history. It can be done in the project details page.

    - Q: What exactly should be included in the “project conversation history”? Is it just an activity feed of comments and status changes, or are there other event types (e.g., file uploads, deadline changes) we need to consider?
    - A: For now, focus solely on comments and status changes. We might extend it later, but the immediate requirement is to log and display these two types of events.

    - Q: How do we expect users to interact with this feed? For example, should they be able to filter or search through the conversation history?
    - A: For now, we only need a simple timeline of comments and status changes with pagination or infinite scroll.

2. Functional Requirements for Comments
    - Q: What data should be captured when a user leaves a comment?
    - A: We need the comment text, timestamp, the user’s ID (and possibly their name), and the project ID.

    - Q: Should users be allowed to edit or delete their comments?
    - A: Not in this iteration. Maybe later.

    - Q: Do we need to support rich text, markdown, or file attachments in comments?
    - A: For the initial version, simple text is enough.

3. Functional Requirements for Status Changes
    - Q: What statuses can a project have? Are these statuses predefined or dynamic?
    - A: They’re predefined (e.g., ‘Open’, ‘In Progress’, ‘Completed’, ‘On Hold’).

    - Q: What details should be recorded when a project’s status is changed?
    - A: We should log the user who made the change, the timestamp, the previous status, and the new status. It might also be useful to include an optional comment explaining the reason for the change.

    - Q: Should status changes be editable or deletable?
    - A: No, status changes are part of an audit trail and must remain immutable once recorded.

4. Permissions and Roles
    - Q: Who is allowed to leave comments and change the project status? Are there role-based restrictions?
    - A: For the initial version, any member of the project can leave comments and change the project status.

5. Data Modeling and Storage
    - Q: Do we want to store comments and status changes in the same data structure or table, or should they be separated but merged when displaying the feed?
    - A: There should be one common table for all activities that have a polymorphic association with either a comment or a status change.

    - Q: What are the key fields we need in comments and status changes tables?
    - A: For comments: id, project_id, user_id, content, timestamps. For status changes: id, project_id, user_id, previous_status, new_status, timestamps.

6. API and Integration Considerations
    - Q: Will the conversation history be exposed via an API?
    - A: No, for now it will be displayed on the project details page.

    - Q: Should we consider real-time updates (e.g., using WebSockets) so that users see updates live?
    - A: That would be a nice-to-have for future iterations. For the initial version, users will be able to refresh the page to see the latest updates.

7. Performance, Scalability, and Audit
    - Q: How many records do we expect in the conversation history, and do we have any performance or scalability concerns?
    - A: Projects could accumulate hundreds or thousands of records over time, so we need to ensure our queries are efficient and that we have proper indexing on project_id and timestamp fields.

    - Q: Are there any audit or compliance requirements that affect how we log these actions?
    - A: Yes, especially for status changes. We need to make sure that all changes are immutable and properly timestamped for audit purposes.

8. User Feedback
    - Q: Is there a need for an “undo” or “rollback” functionality for status changes?
    - A: Not for the initial version status changes should be deliberate and part of an irreversible audit trail.

9. Testing and Edge Cases
    - Q: What edge cases should we be mindful of (e.g., simultaneous status changes, comment spam, network failures during posting)?
    - A: We should consider this in the future but not now.

    - Q: How should the UI handle failed updates or errors?
    - A: The UI should display clear error messages and allow the user to retry.

10. Future Considerations
    - Q: Are there plans to extend this functionality beyond comments and status changes in the future?
    - A: Possibly—if we later integrate more activity types (like file uploads or deadline changes), we want to design the conversation history to be extensible, so we can add new event types without major redesigns.