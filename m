Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E3359703;
	Mon, 16 Mar 2026 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697845; cv=fail; b=J8ZLXRa1NV0GtvbTs8c3eT8+IBlV4zH7Nf5pIt/juYMSIifS4ECsMNEOvc4bIrq/tV7k7BhUZM8vOdtHEEW2RLRAD+3GRzO3EnUL0y7tCkdDVL2CqLqi7BVuZsEpA2ZsGohwjqgaGaTRiRwjcFs5tvG5DBu2m7v9edP1QoS+S3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697845; c=relaxed/simple;
	bh=nwBLaYu9tUacmbRRqo3sS3gXMRwZ3GQ1o0+XsHlJcG0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=JE6WRPq5Z+AdVWxEw4ZPXr37U3BxNLCM7gbDnbxGojK+EaK3n+jOBrbPy0y2MSX7eP+egpX7FU9cDJCnnWGck/CvFZhDltl1XWp7XOY2TmJ53FYKPN00HOyqa0qZkbUqatENscO2D/gi4oZQhPd/ZgWfyrwTrSBbiC+nnJKBGs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BP408Js+; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BP408Js+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GGG0Ea1189478;
	Mon, 16 Mar 2026 21:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=nwBLaYu9tUacmbRRqo3sS3gXMRwZ3GQ1o0+XsHlJcG0=; b=BP408Js+
	K6kDgYgMl3q/JxKRMKYjWmTm31R2uOTIdZCQ9rWXoX8J4ANDGUzlWuh8NXUSRZJ1
	L3KPAM9xQ9FJxEQ6FCFt9t2t9KAS61efFECq54znvi7LzspnfY/QAIhQixseQcCX
	SRuOlG1iIsvzpBa2Htj/9ZsZDQ6gHSWSyGERY/TDSvibd0+FZ+QJhKlwen2F8bfo
	ADh39GB/wvuBfCXj4Qm1AQiAEiFHOruFMiNhT8eF1sIlzWpVPbsGd6KHDWM8uC5/
	pZ5be4nxT/DU+dDfpw4IC7i9XNd7emFwjhoTPSrvi9Yu3VvbXFU9DJeove8J1/vb
	9jnQ7eJX6XkOrw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfc4hv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 21:50:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLMTmNVwQDOSABAMWwnskfLqb0EKThS1psnyFrKUs76/XHE+QL121fsEpbHy45/lb+3rX515BvDgHI6GDHk5XUBJqAN9B/YL0ubxKuIDuDikggf+9UGVc4fg6oqmv2b3K4E3Pt6W9tU+WVFHtEK3deX/fzumxYjXyaCM7qXd4GdGDup2fMC2/r+/S95cvHHqRdKeks1lRtdLOQsa+KXuH1zKoFWH7mxpaBj7/EQEOm/lwWMyWjLxGVBDLXqAX/4Ep8JWdfdegL3deD53MMKV8mzdTufdYXykFohOFbiLAxpPKcL1h5fKwB4dhSI4Qo6xx8POjFcEiAmgQmhYVhAkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwBLaYu9tUacmbRRqo3sS3gXMRwZ3GQ1o0+XsHlJcG0=;
 b=USK+F/Nl5mJGtLaCQh6tWB013zLdxzzelqBeocGZvxu3iOVa+VbXEvFpdFheloy46fyugaBE5vbKZqRGmvHFZtIf3bFVg3NEJKHv8rWx8K/DCoUeOKzE6P9nECZ/92UCIdX8Tq4/l9fpGK7wABm8cWYjgsAwM7lTjQXXmt3paznUoOpnZq/q+yQ4n2BpM7JCflVW0p/mqfbdMLAnm/DsHQa44AnFVoRc+PmYFKi4t95h+DLi8Cto5QgkGSwFzNYKdPuvOj0tGpsrtFe8oNCo7lGP81SVdE3NTgboikNrHjygUk9PqWtJqRxzG1TMTuRYsMJexVw1lncnmTtoX29wCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA6PR15MB6641.namprd15.prod.outlook.com (2603:10b6:806:418::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 21:50:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 21:50:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
Thread-Index: AQHcsg/APN5tsWR8/06I9Ew1VYcR+rWrh4IAgADGZ4CAAH/BAIAAx6WAgAQkTYA=
Date: Mon, 16 Mar 2026 21:50:14 +0000
Message-ID: <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
References: <20260311211309.27856-1-contact@gvernon.com>
	 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
	 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
	 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
	 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
	 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
In-Reply-To: <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA6PR15MB6641:EE_
x-ms-office365-filtering-correlation-id: 4b999c5f-3319-49a6-b563-08de83a6015c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 C1M8WDBD1z843rFQVa3XY69uYSIpclzJhP+iORYBoSAlYIZ0aZPL1VRMcjZkZ82yCnL1a7sgOkoZyNL1A+UZmlSNIEUSvYQVcU1StJL1eHFpSAO7YBbWz/yaW4udh576lu/sWIrTh7ApS0F007CM6vLziw5zUo+fgJz/DR+QVKPwwLmC72fTYCU9Gu2K6yImcC9HIXVM3crFH6zKEki6wQlP1ak7BTSPF8A3ximDP6RUd6dJWJgcvn2AvlND7m7xDooWX1IQ1PY+ZSRXZnLxoMl5cSNv2aYWjKMvxvGCUYEp2aa9ga3b193+fcxV66B3O5M0LbnEuCVPdbZoIUN+bNSszWXDDpljCWADRPUgQD3HhTSL+k54IV/gNceXMQQVg60N8EHLus7O7CHLjTRqdUO0LfSl8lI1Fs1rEjYngh31szEgAJHZB2V9QarImCp7mdPKRjdq8sVrwA8o4exUC+U9mi2pFpLqseiKvXEhaQlVUO9z2/ZzJjkfYdj3PJZKoPYJu/igrP49HTZz+Au4+wEW6ah/sLugipdEpf0BWe2GI6dRMrA//ZINPJN8ZOkSw/aEhoijNH8nPXz4hC+ym+YAmUXQhKBLK/OUSQucLZdneaJo7qP2l6QPfz4CuA00yD5OVz5RIFbtagjKNhqz1wtMSFlbFhCWidvlQT5Hh7V9Nd11hHc7loz3CnqHnD1FEvqVwAPUnuIaZRE6BUb+x19SRpN046TbS8TuT4vnuJf/MQqZyshxDydeLG/uJOL5X98CezRW9djeXBIVZX6+vmnULcUQmeaGGK/43GHpSnM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REE5VUtsVElBN0E3WnFJRGM3Uk9aOGIyWTk4YmxtZFVrcjN3RGhSMzJlcy9j?=
 =?utf-8?B?dXRySW42NTdyZjdVekZHZ1JZemhXei9ZSjJXNGpBRmE4cWJaeDd2UFBZWlF1?=
 =?utf-8?B?SU84Ull6U09rTHBKMzlnNlJtY2dBWnM3WG1rMktBSEYzTnZxVndlakxWRldz?=
 =?utf-8?B?bHVsSlJGTWxCb04vclRrbEZDY0QwYjdmQWU3eE1Idm5XcFpBRUdMdnRNNUtL?=
 =?utf-8?B?YlB4Z2VDbkF5WGdEVW1GbWdxNjBwcGtvbktNYitVY1BadE8rVlhXS0Q0SXFz?=
 =?utf-8?B?VTJoVHExNjJyVGF4YThuc3l4dy9vTUFuZkZEVXovM3lvU09Ba0h6dmttanRo?=
 =?utf-8?B?YXpvbmpuVE16MU95VVJ6aHlRUU5RUFBtdTZ3czBTbm5GS0cweGNDYnJIRnFE?=
 =?utf-8?B?RmpyZWhrUi9lZVRONEY2QUJFbWp5ZEVEVTRiaHZYckJ4RlF1cWIzOTJqeGpv?=
 =?utf-8?B?OXlkL0VJczNtNFpoVDl4cldSNEZXTjNmR2R6alo2aHJiS01nSkhydEx5MGpV?=
 =?utf-8?B?STVtbjl1Wk01R1IzL3dwbE1mbDl6Ym9ERTNBZ3dGSTlXMHdKeVFUVzlkS1V6?=
 =?utf-8?B?OEp0RWNvdmpkN0duNXUveUE2YkRWUXNDMXpWSzRUSndWTE1sV3ZsZ2FVdThH?=
 =?utf-8?B?c243R09QcDAxZFhIdXRpNzhKS0Zjd1BFdHhYZ3BlbWc0Z0c5ckdSMGdyQXRJ?=
 =?utf-8?B?M2l2RTFPVFR6bW9kS3kzdWEyRVdjR0NkOFBFcEFqeHB0aEtENTZDNzdDNzJj?=
 =?utf-8?B?RzZaZG00N2JIZHFmeFBhWWFwN2lRSFJrNWtZTWdWcFNGbk91d2VKb2Jsem9x?=
 =?utf-8?B?T3gvSnR1Vmswdnc2VHlhT3M2L1lWdklDYVo2dDdWTFkyMmxpcGdocnNMSkYy?=
 =?utf-8?B?dm9OdG02WkZjenI5K2ZiYjdqZnVTeUZ5bjFkcEVIdjJQVHg0MWM5UW9yUDVJ?=
 =?utf-8?B?aVBLSnlzT2pONmc1QnM4YWZjNk1xcHowUERuTFF1QzIvQkZWUllqVVdYdWly?=
 =?utf-8?B?bFBYZHRoS0gvTXNwWElNcG4wUlBCOVFDdU1UVXJ2dE1UK1ZrWWUvWTBySkpn?=
 =?utf-8?B?WmxSelpodVRLVklZM1FJeUd6YW9CRTlGSHZZaGlkTHBkRWtKUDRyWlEvK1Ru?=
 =?utf-8?B?ZkNqSHp0ekZFUzVJTHk2NE5wK3V2enRWL29lVVE0Rm5QakFhNXVEZUptcGR6?=
 =?utf-8?B?VUdzM2xQNCtzSGJraThCc3g4NlVwYVY0bTJQNGpKNEFTY1Y2blAxdnM1Smdp?=
 =?utf-8?B?aTI0bzFYVkYvK3JBS2lMZXRtMUd6OHZLak9ZMkE3ZGQyK2k4ZzZtUWQvMkdO?=
 =?utf-8?B?V0t4Zk5mSmlReTBIdTF3WlNvTGFZV2JCdFZmdXAzekVwZEQ1UDk3ZDZQeWJE?=
 =?utf-8?B?ZUhPUzVrOG9aRzVRbDZKSXFia084QlJrREUyTEY1eHJTY0szWFIySEVSRDRO?=
 =?utf-8?B?MmhHTnBxNGJFczg1Smh6OFFBMmFPVFZuUmR4ZURLSS9EM2w1WjMwMWRBVkhh?=
 =?utf-8?B?QWhFR3p1aXNCTDZwVzNleGd0MW1EeEpMSi9LN0YycDFRRUMydk9VcWtqUHgv?=
 =?utf-8?B?VUdwT1Iydi8zQzl4SDEyNVFRaGFQZmNvVUEvUVV2SlFZMHdLVXdod3BLSFpi?=
 =?utf-8?B?VXRLNE5Rb2VoejYza3VVTWM1cnVaV2ZnREtDd3NKTm11aG4wa0czODFmWkxU?=
 =?utf-8?B?QkxmdFpPVTJsT05IaDNGZTZyenBkRTJQNjB2cUY1Y0Z6eGIwa1kvaFZsMW40?=
 =?utf-8?B?RzZkZEZHaXRaVExjcmEvdEhRdU9TMkJuU0xQRzcrdG1ZWXBHSmhoTTJXeFJO?=
 =?utf-8?B?MFE0WDkra0IveDczS0dnZ1pDVldoRFgyemt2NlRabWtZODRlNHowZ0k3bi9z?=
 =?utf-8?B?c1lGVkNhcVN1TFhTaXhUOUYySE9mb3ZhZmlLaVNwSjdGWCtuYTdzMUFYczA4?=
 =?utf-8?B?cXdVY0YrYnNPNlZHbE1aNjZ5MkptY0NkZkxmakJwUGFJYmRXS0k2WVJYWGNo?=
 =?utf-8?B?ZFF4L3VvTWxaaFE1KzVYcnlFWFZiVnlXR2gydU56Uy92eStVR2lQSVdIM0dT?=
 =?utf-8?B?VHpHS0J5YzZlR3BGR0puc1cza3VFS0RZNmcxL0FwNDN3SVRHYm8vYkd4WU5j?=
 =?utf-8?B?Vy85Nld3RDVFSFVjTXFvaGc1QjRGdWVZSWs2ZTk5ZEtNL211RUVSWjdoYlF3?=
 =?utf-8?B?UEtJMFVaYU9FQlZ6Tnd4ZmVmYm9hbXhMdGNpSkJnaHQzazY4QlBIRlJoQnN2?=
 =?utf-8?B?WURJbTN4c3FFQU9SRGpUNDN4K0huMXVWcmhFTWFlUjg5M1Z0RGh5U3JVRkJi?=
 =?utf-8?B?ZGRBejlydnBnOG55NCtycWZPOExJaFI2MXQwV2xTVllIT2d0WFR2ei84c3dp?=
 =?utf-8?Q?gaYTGEsKkSj/NR/MuPKT6xfwAnbZJtSWK70m7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B43C9CFD2C64946863109CC684A61A3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	i0ZJc8jf0H+29pbnP63fL7B+nNX9kKsZzXuuCb4dO2PNC9237+xLWdXVQJb0n9gRuXPgA8NCWim0kg4u6EFw4PsyWqXMPZbbO+O1AIpor2WyOQdz5b9nZue0/gYSarolJkzIwsvKwh++qvZEgtYAwnn5I8sfdExQoO6VKvAcp1T54oK+3D0T06l7b5V3bIbRVSnAmsVoOzT8tIjrKuFTiFoUDLxqermF7xI+qfDw/U+vfVt6kdvV84b+H7I2qLSA/O4761waKuqKALfBVzlfIPXduvC58HjPq1BzEfdJ33rAiXiw0NPRiDvD7qB2xPdjIUs1BntShip+MOCvo4UBKQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b999c5f-3319-49a6-b563-08de83a6015c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 21:50:14.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zm7FkxMkwIgxfhVu3yATX8Hcby1SJTUbjG3g6fZFtxw69haNsj6+WGjK/74bAxsAZV3wZ5kSApSVjZBXCnpx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6641
X-Proofpoint-ORIG-GUID: BAXVDE-xcxncfTt8sna4-x5tJB70RTp2
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b87b19 cx=c_pps
 a=f5Tl6ILaYY6UHEJdjUIuFA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=qvcJHsXA2wjg93sKGk4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE3OCBTYWx0ZWRfX3RQf85cD79I8
 brCyXUxYKkRDcsVFocLpNaxF8pO4nrwEDEhOGLLN0xmt+HO3NZp7V7ysOXflG8Xqbxv5kqWc2x2
 kMCVrGCq3qf5zDalRKwuhg/ZV/K6HjkZDwYGWxSRmowNpMu2qB58us85LpJMoolNueDXsdJmjAC
 vGeylT3cKrD8aAl3Eb2pwgt60dzhrsSYkUonhSJIfvN6xkAFD1owBYqUX0NuNnVXiR5jI2heFWT
 CnYOkiqGJfp15nZCainzbo4Ec8aqv4qNmZyG7KS+HYxoTBsw7Det1emQ6pbOTomJxskdLo0TUHh
 E7DQTfo2tZ3b8yWZzqbLt22JVtteXhjxpTgzMBvR3fxTr7Rlnd18WHbB+baj2bEBQl8lI8U2TqB
 hnQsJ1GBb0EqFc9pzSaeRFMY88oVHc8LmJwbB9drtKd3yYPN7bK+8bDe11r54UVRkxQCraAU/G8
 vOzXvRtfpg8JSsoncuw==
X-Proofpoint-GUID: BAXVDE-xcxncfTt8sna4-x5tJB70RTp2
Subject: RE: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160178

T24gU2F0LCAyMDI2LTAzLTE0IGF0IDE1OjM1ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDMvMTQgMzo0MCwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9uIEZy
aSwgMjAyNi0wMy0xMyBhdCAyMDowMyArMDkwMCwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+ID4g
T24gMjAyNi8wMy8xMyA4OjEzLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gPiA+ID4g
QW5kIGV2ZW4gYWZ0ZXIgYm90aCBjaGFuZ2VzIGFyZSBhcHBsaWVkLCBteSBwYXRjaCBzdGlsbCBt
YWtlcyBzZW5zZQ0KPiA+ID4gPiA+IGJlY2F1c2UgbW91bnQoKSBvcGVyYXRpb24gc3RpbGwgc3Vj
Y2VlZHMgZm9yIGNuaWQgPj0gMTYuIDotKQ0KPiA+ID4gPiANCj4gPiA+ID4gSSBkb24ndCBmb2xs
b3cgaG93IGl0IGNvdWxkIGhhcHBlbi4gUGxlYXNlLCB0YWtlIGEgbG9vayBoZXJlIFsxXToNCj4g
PiA+IA0KPiA+ID4gRG8geW91IHJlbWVtYmVyIHRoYXQgeW91IHNhaWQNCj4gPiA+IA0KPiA+ID4g
ICAiV2h5IGRvIG5vdCBsb2NhbGl6ZSB0aGUgYWxsIGNoZWNrcyBpbiBoZnNfcmVhZF9pbm9kZSgp
PyINCj4gPiA+IA0KPiA+IA0KPiA+IElmIHdlIHN0aWxsIGhhdmUgbm90IGNvcnJlY3QgaW1wbGVt
ZW50YXRpb24gb2YgaGZzX3JlYWRfaW5vZGUoKSBmbG93LCB0aGVuIHdlDQo+ID4gY2FuIG1ha2Ug
aXQgcmlnaHQuIFRoZSBwYXRjaCBpcyB1bmRlciByZXZpZXcgeWV0IGFuZCBpdCBjYW4gYmUgY2hh
bmdlZC4NCj4gPiANCj4gDQo+IERpZCB5b3UgcmVhZCByZWxldmFudCBjb21taXQgaW4gbXkgcGF0
Y2gncyBkZXNjcmlwdGlvbj8gV2hhdCB5b3UgaGF2ZSBiZWVuDQo+IGZhaWxpbmcgdG8gdW5kZXJz
dGFuZCBpcyB0aGF0IHRoZSB2YWx1ZSBmaWxsZWQgaW4gYnkgaGZzX2Jub2RlX3JlYWQoKSBjYW4g
YmUNCj4gY29ycnVwdGVkLCBmb3IgdGhlIHZhbHVlIGlzIGdpdmVuIGZyb20gcmVsZXZhbnQgb2Zm
c2V0IG9mIHRoZSBmaWxlIHN5c3RlbSBpbWFnZS4NCj4gDQo+ID4gPiA+IFdlIHJlcXVlc3QgdG8g
ZmluZCBleGFjdGx5IEhGU19ST09UX0NOSUQuIElmIHJvb3QgZm9sZGVyIGhhcyBhbm90aGVyIENO
SUQsIHRoZW4NCj4gPiA+ID4gd2Ugc2ltcGx5IGNhbm5vdCBmaW5kIHRoZSByZWNvcmQgZm9yIHJv
b3QgZm9sZGVyIGluIENhdGFsb2cgRmlsZS4gU28sIHdlIG5ldmVyDQo+ID4gPiA+IHdpbGwgY2Fs
bCBoZnNfaWdldCgpIGlmIHdlIGNhbm5vdCBmaW5kIHRoZSByZWNvcmQuDQo+IA0KPiBZb3VyIGFz
c3VtcHRpb24gaXMgYWJzb2x1dGVseSB3cm9uZy4gV2UgcmVxdWVzdCB0byBmaW5kIEhGU19ST09U
X0NOSUQsIGJ1dA0KPiB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdCB0aGUgQ05JRCB2YWx1ZSAo
dGhlIHZhbHVlIG9mIHJlYy5kaXIuRGlySUQgaWYNCj4gcmVjLnR5cGUgaXMgSEZTX0NEUl9ESVIs
IG9yIHRoZSB2YWx1ZSBvZiByZWMtPmZpbGUuRmxOdW0gaWYgcmVjLT50eXBlIGlzDQo+IEhGU19D
RFJfRklMKSB3aGljaCBpcyBmaWxsZWQgaW4gYnkgaGZzX2Jub2RlX3JlYWQoKSBpcyBhY3R1YWxs
eSBIRlNfUk9PVF9DTklELA0KPiBmb3IgdGhlIENOSUQgdmFsdWUgaXMgbm90aGluZyBidXQgMzJi
aXRzIHJlYWQgZnJvbSByZWxldmFudCBvZmZzZXQgb2YgdGhlDQo+IGZpbGUgc3lzdGVtIGltYWdl
Lg0KPiANCj4gU2luY2Ugd2UgYXJlIHBhc3Npbmcgd3JvbmcgQ05JRCB0byBoZnNfaWdldCgpLCB3
ZSBjYW4ndCBmaXggdGhpcyBwcm9ibGVtDQo+IGJ5IHVwZGF0aW5nIGhmc19yZWFkX2lub2RlKCkg
Zmxvdy4gVGhlIGNvcnJlY3QgZml4IGZvciB0aGlzIHJlcG9ydCBpcw0KPiAiZG9uJ3QgY2FsbCBo
ZnNfaWdldCgpIGlmIENOSUQgaXMgd3JvbmciLiBZb3VyIHBhdGNoIGNhbiBiZSBhcHBsaWVzIGFz
DQo+IGEgZnVydGhlciBpbXByb3ZlbWVudCByYXRoZXIgdGhhbiBhIGZpeCBmb3IgdGhpcyByZXBv
cnQuDQoNCkl0IG1lYW5zIHRoYXQsIG1heWJlLCB3ZSBuZWVkIHRvIGFkZCB0aGUgbG9naWMgb2Yg
Y2hlY2tpbmcgdGhlIGV4dHJhY3RlZCByZWNvcmQNCmJ5IGhmc19jYXRfZmluZF9icmVjKCkuIEJ1
dCBJIGNhbm5vdCBpbWFnaW5lIHRoYXQgdGhpcyBsb2dpYyBjYW4gZXh0cmFjdCB0aGUNCnJlY29y
ZCAgd2l0aCBpbmNvcnJlY3QgQ05JRC4gQmVjYXVzZSwgaXQgaXMgdGhlIG1haW4gZ29hbCBvZiBo
ZnNfY2F0X2ZpbmRfYnJlYygpDQpsb2dpYyB0byBleHRyYWN0IHRoZSByZWNvcmQgdGhhdCBjb250
YWlucyByZXF1ZXN0ZWQgQ05JRC4gQW5kIGlmIHdlIHJlcXVlc3RlZA0KdGhlIEhGU19ST09UX0NO
SUQsIHRoZW4gdGhpcyBsb2dpYyBzaG91bGQgcmV0dXJuIHRoZSByZWNvcmQgd2l0aCBleGFjdGx5
DQpyZXF1ZXN0ZWQgQ05JRCBvciByZXR1cm4gdGhlIGVycm9yIGNvZGUgaWYgc3VjaCByZWNvcmQg
aGFzIG5vdCBiZWVuIGZvdW5kLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==
