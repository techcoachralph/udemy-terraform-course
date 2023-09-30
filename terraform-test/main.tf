variable "myvar" {
    type=string
    default="hello Tech Coach Ralph"
}

variable "mymap" {
    type = map(string)
    default = {
        my-key = "my value"
    }
}

variable "mylist" {
    type = list
    default = [1,2,3,4,5]
}

variable "set" {
    type = set(number)
    default = [1,2,5]
}

#variable "boolean_value" {
#    type = bool
##    default = False
#}

variable "list_two" {
    type = list
    default = [10,9,8,7,6,5]
}

#variable "object" {
#    type = object({
#        my_string = string,
#        my_list = list(string),
##        my_boolean = bool,
#        my_set = set(number)
#    })
#}