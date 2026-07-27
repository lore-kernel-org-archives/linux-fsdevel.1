Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021112.outbound.protection.outlook.com [52.101.95.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5E3EFFD2;
	Mon, 27 Jul 2026 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153229; cv=fail; b=cd7STyuKsk5TsIt2Oz4x5PfO+cta96fjWae5QOaGlUtwI7Dvuqz0kqbNcNhEwhb5aqza3o5/LpmsDUhOF7MS6gQbT3nsyjGtGPYGoIRve0tCgc5iApszH76Wr3sqZ22f8j9pYSxdqe4h/s4Yy8df/YKACYdCoflpNxmtItg/Ers=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153229; c=relaxed/simple;
	bh=xV5Dc5dG+Ijd+IcewVB+5T5ymnfpM971fLPS5ZHsC1E=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=QaR/XP13nCUEJ5KQ2d8/8tOyJYwevxIGkGwj+ro+EQHak+TW+jSaoh/v9bM5exOfirlNq6rBdt+qfdPX3vCr6Ajx01SBVbdnrdhwjev9+hT59gsnhcBF8Z4ucGGyAPSHEmsC1nSlc62yLVeYhU2qwEXS7uM3juCy3+n73WXXXmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cgqV40i7; arc=fail smtp.client-ip=52.101.95.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cgqV40i7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYYZGq4HkSE1n5caoO/SmvO9KLFpgDviw+DPPmoVHMnqmCu7WDo+9xKGSfPT158ySlFM/rW7XqC62lCvFI2p0f0IImc+JXbs5dFAB3cfNlzkle6podlMLWmBzjti6wSlzdh/e2u3SKN30wruCnQEzl+gDgR0GXZ5CRLvMdITeCJPLQDEYEoxj3k8ljG+G3N1CU4WLQ4PEHDH0UghamZ/4XrCWBsrYQOYVURl1ok8rq8Ak8iZckzCwi2Iq8EL+1B3OfkyIkWaKP7WObytTvEXxXdOYfTiR/ihcqJ7dq7rF9uvn7ZtyaJ7kPY1bjKbJXCD9NmErAz+8R5Qc80oWp++SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB+O/ULIFnyoXUuso141mkRZmWmlCMsDJqjSphUPWSs=;
 b=ROVRHFeXUyKr8YnuVemmMopVMidwTP711VZQ7K1GD9TM5McLKsNKKdNfh8zbHrtCCO6PcudZTD4cl+cL0PZYiT5zEJkcDxEaMIKf52WS9NDWaP0n1CwFQXyjKI3THfdLB0UyeoB7C988d+0KVCckMyPQjdXwn4jfR+ykZB3xk5WbJf/Y3tCFkgahgml1RkUBEj8L8IFyN2vnFhcsQTyNHrYZ2eJl8/wPc9E8q8ONWYqj00SPcgYxQAJV9g2bdOriW1PUHEJ4LIepC9MEHt00qtPZsfvyRZVZmdq68/Ot4uQy3WMvmuKlTVaEkbgmx6wbdfeVkCKzTti9llrd6GUdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB+O/ULIFnyoXUuso141mkRZmWmlCMsDJqjSphUPWSs=;
 b=cgqV40i7rec7ZSziPyHRSsdxD/0LEulgFw+ZiJrt0oBndcbxj1w0/9/1PNh3omsVvIVj3fJn0yN+1WEA2A8IXLLOCGWIar2p7EkOfXtJ9LrURMGASd+QGUxJtswiqG42YZAdRW2b8xL5l9fi92CXi61bxS6m8xErguYT25AnmAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB8515.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 11:53:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 11:53:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 12:53:44 +0100
Message-Id: <DK9C05NS2URM.13IF54K7K0FE@garyguo.net>
Subject: Re: [PATCH 2/5] rust: workqueue: replace deprecated system_wq with
 system_{percpu,dfl}_wq
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <arve@android.com>, <tkjos@android.com>, <brauner@kernel.org>,
 <cmllamas@google.com>, <aliceryhl@google.com>, <boqun@kernel.org>,
 <gary@garyguo.net>, <lyude@redhat.com>, <daniel.almeida@collabora.com>,
 <work@onurozkan.dev>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <kprateek.nayak@amd.com>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
 <longman@redhat.com>, <viro@zeniv.linux.org.uk>, <jack@suse.cz>,
 <tj@kernel.org>, <jiangshanlai@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260726223613.1242940-1-dakr@kernel.org>
 <20260726223613.1242940-3-dakr@kernel.org>
In-Reply-To: <20260726223613.1242940-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a26d6cd-2e55-441c-59ae-08deebd5b5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|10070799003|366016|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	guJvsuh/P3+/Z6fnp8kHdjVU94xubtgPooTxpshYGxltgxr4PUxoquBgxI2FZ8ahnQ4rKgph852p3rvi8BG3XDb2LBRfbUUkN6ut5stHJMxXz6w/3hLFwSwZosGLclpJLWbwznQYsMIxoi07bKZ9IVV0U4vkJfx0eb8SaoSQJgqku8PY3xIbwkMnbFlDOqrlW8YKywe+92DJU6bEfpzAjngIjlseQ8G9wTWfzSQxhOSmw+4tCRDUm/dQURdlOzA7XSspDNz7pOeWgnhgAf/8XbuDniS9+mJrMo9uu+YxCVt9MS0WRFwEN9tqiqd/YiRHFGdjSw2s3afjxrRPC5U36HjSh7CKhymsCsBVs16Z8Z77+2NHpwVOF2SOeDbdobuOENKITxm59n59bVBAQU0+aqNFGHBLVmdAVk3PpQWHLjS+bC4zhvkUDmMwgfa48zkRb5jELUot116nxNOoRiQm4YD7kTT6QyQmIynuTpAS2RfkC12nVWV3DyOXnl7p0BhJUpK/oClf85r5yGkCoiX8ks8X27FXG0yAYcTlGhO/fhCo6TIJldkTUZTG9+JgFaGh7+N7XfGYZf9wdXOYjTBhQXmBM31nsmVNA9aiDyK5DXw14ZkVF+5tCB7E9mFzm8LMss0DjwVzW6Y7pwWeUSR62nrj3X4J6ZZrBXbAclj+9YWYOahSY4PxuIvsVhP9dOBhEgSIWoAKPCIXRfYlK1Sy8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(10070799003)(366016)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkxhamVvUmJMU003Mi82TjNGbVhoY0o2anBxd3UyM09wdjRGUVJPR3B1SzR6?=
 =?utf-8?B?TGwvYmRLa1dUWUxOSTBqNC9MUUNHVlhjeVd5VUd5VmUxZ2VnK2FnaEpoWUxx?=
 =?utf-8?B?aGtoNS9ubFg3OGpkc0VlUCtscFZhVU9FWmkrNVRiQmJRaWt3NGlOWlh4ZFZk?=
 =?utf-8?B?MGpJLytVcHM5R1c0ZDhvb250TWNySkkrQkFGcmY1TmxtckduekdsRmFiZWhX?=
 =?utf-8?B?WXNnNjhBZ0w4bGVFU1hOUDJnNXdwcXZhS3RDcmRRZ0hzVmlhQnVmd1QyVWdu?=
 =?utf-8?B?aHorbk5iTHc1eW0wWmtRc0RUdmswL0w2QlBmSzZWUjJBTzBCRjBPMUNPNHpl?=
 =?utf-8?B?RDRHMzRhRUI5dGJ4N3RjdmRvdFppQkZLTFJ5c2xOdDRRdWFDNjJpV3JNaHZZ?=
 =?utf-8?B?aENWelJGK0ppeVhXUENGSnQ5eC9WdDM3bGwxTGVDV2ROTno3a3FScWt0cnQ0?=
 =?utf-8?B?c2dNM04xR1BTc3NvZDdqVHpSSkhjMms5amt0Qk5VRTNRNi9RLzRCK3RiTTNJ?=
 =?utf-8?B?RnZZL1U2ZmhIaXFvbCsxWDFDUmxoK2R6MmlBNmtId2hoajZIbmRoZXRaT3dr?=
 =?utf-8?B?SVJOeS9HN1F5VGd0NnEvTVZiZSt6V3Y3RURTSzRxdndrNU5wZ1FqOEU5K0pC?=
 =?utf-8?B?Y0JhZEd6VXRvUk95VVJmTUdVeG83TnJIbXl2QzBrUWx2b2JKWUJBTmIyY3d0?=
 =?utf-8?B?OWVZZnpnSTR2cnpwbzJzUnVhZlhPRjdjSU1wNHE1NldkWWhwMit3TXdqNSti?=
 =?utf-8?B?TUVYOVVTdkRjSkluUG9pYnphR1NGTWdBdUFTdFFIUzBOeTREVzNqd1dnWjhQ?=
 =?utf-8?B?Y2xZYXdOMUFIdXV6azRJU1ppWCsxekFydy9KVldFL0JrcFVXOWgrejMwR3VS?=
 =?utf-8?B?Y0JhMUtzbU93MTVUeE1oL3ZtcUtTVHk4Ti9RUEUwRldhdDNtUnI1ZUtsc2NT?=
 =?utf-8?B?RVVOY082WHUzK1pKNGZjaHJGUnhDN0FLd0xmcEY2QzVWVEpXWWQrWXRFRlZ4?=
 =?utf-8?B?aUNZVU5wSi92UCsxMEh2QnBYOExldHEwU01xeXJFWmV5aStYeWZLSm5jNDZN?=
 =?utf-8?B?MlZmQ1h3dUxKakpLZW5YUkNYYlZSTTZFYjB0dkVvR1ZscnZ4RlpnRXY2dlFX?=
 =?utf-8?B?NS9xRlozRUpKZUJWZTh1QUgrbkdvQXR3QjFkRjNqT3dLNWJUT3JTQVh3NDBa?=
 =?utf-8?B?Y1NqN296T1J3RG85M0I1a25va0ZwNW5WZ0wrdEdFbGxZZU5oQlN3ZG9icldm?=
 =?utf-8?B?ZUQ3SEVLV0o4dUFQSGdaNXlibXFNM25KNjNMRElvbVA5QmpVREc4R2FiNVg3?=
 =?utf-8?B?bDkrS1lOTW5rSDdrNzFFWjRMZHBiRHYwbE1lMDV1RTQ2NmxweTJnTEhxcmRx?=
 =?utf-8?B?Z2ZYdktqK0xxdGpzNFhMditJVmxuT3prcEY2UnJrbmZNd2VySXV6QzNJVkhw?=
 =?utf-8?B?cnErQUNHSjFDRmhDemV6VFRmaDRyV0xsRnV5OUpJNTM2VWNSTUo0RUxnSVhM?=
 =?utf-8?B?TitjS3RLWUJ4OTBnczRqWnlGUTI2N2k5bi9BK2IrTU9zTk9pUDZQQkxjdWU2?=
 =?utf-8?B?b1hpV3NDdm82QXlEVDJSUXA1MjJlVFU1VVZnbjJUMFEvcnZiVmgxUFR2cFA2?=
 =?utf-8?B?NllLZEgzeUlocU9BUURnWDFwNUtXYTRwRjRKMlRZeVJpK0RaWnF2QUtSRGQ2?=
 =?utf-8?B?aDBISWJ3NWtoMVlkM0VIYjV5TTZkeVE0SVcwaGlNNW5hODRiRUx4MGhHSmcy?=
 =?utf-8?B?bVFDczJCWDhjVWVTTnA0VWlNMFErUjFnRks0WVBINWk2OFowUStOc2UrWUU2?=
 =?utf-8?B?MGtWa1kzM2l6c3ROcnBLRXhQMGVGb3dGVXM4S3pNYnhVRStYTVVCU1FtKzRh?=
 =?utf-8?B?VlJCOWltcVgzeWRhbUwzNkNCZkMvZWxhRmFmQzdaMDJIOFlkb0gyOGtQOGVI?=
 =?utf-8?B?ZWFhTVNHOGUxM1pHZ2kvSXZ0bjhONVZZNERrSUgzelYreWhtR1lJdjZBd3Zp?=
 =?utf-8?B?dW8rRGJkT0paS2Z4QTd3N2Y5aEEwZXdRQXU3WVZqL3BHRFlYMjRZc3B5TW1N?=
 =?utf-8?B?UXZIMWhXdTlIOGRUbnBQbEFxN09pa1k1OGQ0UVdvekpBK3VXN3VOeFNEK2Vs?=
 =?utf-8?B?L0YwdXE1RjFiM25lQWdnd3pTOElNbWhIemxrc1IxeWN0dnBUTkpZYVRmVmpn?=
 =?utf-8?B?RTVmcUk3eU80WXBuNUMzVytYbEVUa3ByT2paTlcrb3F0TTkzS3pVazBMU3Qy?=
 =?utf-8?B?Z0xkM3dwOFFjcC9MS3pUMG1NNFdEOEsxblVLYnJZeHRGRlZZbnJGbUtIVkUy?=
 =?utf-8?B?UWpJYUtDeXc3OFdUNnJBa2IwQllZTWUrcUIydm5JZGZ0MjJ1VUNRdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a26d6cd-2e55-441c-59ae-08deebd5b5f2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 11:53:44.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpdrI22MFAiKqNRTe3U6BybUkEFqpUVcCxlCdNVM8VsrdH6S+vxPLEM3pfN+/R61DI2uaJO4kFkyk7MKOwlAcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8515

On Sun Jul 26, 2026 at 11:36 PM BST, Danilo Krummrich wrote:
> system_wq is deprecated and triggers a runtime warning:
>
> 	[    0.857414] workqueue: work func ...WorkItemPointerKy0_E3runB7_ enque=
ued on deprecated workqueue. Use system_{percpu|dfl}_wq instead.
>
> Replace system() with system_percpu() and system_dfl(), to match the
> previous behavior of the deprecated system() and convert doc examples
> and tests to system_dfl().

Hmm, it looks like
https://lore.kernel.org/rust-for-linux/20260203152818.317806-1-marco.crivel=
lari@suse.com/
was never applied.

Best,
Gary

>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/android/binder/process.rs |  4 ++--
>  rust/kernel/sync/completion.rs    |  2 +-
>  rust/kernel/sync/lock/spinlock.rs |  2 +-
>  rust/kernel/workqueue.rs          | 40 +++++++++++++++++++------------
>  4 files changed, 29 insertions(+), 19 deletions(-)

