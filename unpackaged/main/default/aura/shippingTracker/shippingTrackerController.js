({
    handleCreate: function(component, event, helper) {
        let workspaceAPI = component.find("workspace");
        workspaceAPI.openTab({
            pageReference: {
                "type": "standard__objectPage",
                "attributes": {
                    objectApiName: 'Trac__c',
                    actionName: 'new'
                },
                "state": {}
            },
            focus: true
        });
    },
    handleView: function(component, event, helper) {
        let workspaceAPI = component.find("workspace");
        let recordId = event.getParam('recordId');
        workspaceAPI.openTab({
            pageReference: {
                "type": "standard__recordPage",
                "attributes": {
                    recordId: recordId,
                    objectApiName: 'Trac__c',
                    actionName: 'view'
                },
                "state": {}
            },
            focus: true
        });
    },
    handleEdit: function(component, event, helper) {
        let workspaceAPI = component.find("workspace");
        let recordId = event.getParam('recordId');
        workspaceAPI.openTab({
            pageReference: {
                "type": "standard__recordPage",
                "attributes": {
                    recordId: recordId,
                    objectApiName: 'Trac__c',
                    actionName: 'edit'
                },
                "state": {}
            },
            focus: true
        });
    }
})