Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366D246774;
	Tue, 28 Jul 2026 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252580; cv=fail; b=Igf1Y6aNcUY829M57ckUsnKayYgNQCH8pOC0marC3TpeO2JiCpf/mbgaZSdnl5BLnfIiH1NS0nHP0o5EroEuG2LGvrN6dNuCdVJ9owEgO2+3ijvcCrmPRL5Bhj2ud0p4Au3IFf3w4PV1pw+Wu0Gzkcga/DlsfU6HOn7Cg9fFwj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252580; c=relaxed/simple;
	bh=RmUl6+LFPSa3v2QCGM56jPYMqr+yhP0Sifl/YLcQm9U=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=NJ7NWQNV4NM7GxGc0NgghoF7yhDsgfVp9xIl1ppI76XypNMrogm4SE3Im36d4lNCD/f2i+JgmhRSGx3MHwNgM9mIr0KXBr5ddHEV7mO4LlnN1DN3ezKyFd7JhQZcpgHnqm/Pnz94E/XRSO0tlGyZtYNOdbQw7qrpHwSdmWefo8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fqsmh0Dv; arc=fail smtp.client-ip=40.107.200.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fqsmh0Dv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbSx0cMnxmUv5rtLe2qHyIelYfY+/DwBv/pbGI7sMhEM8hI9nkeWvVPDkF2lccMk0axYpTY3HMnpoGDpLLGt+u2PFlb67rewkJfoC5L9XS2DYHvGpqm0kcBXlbUqguTn5t4SJGxwQAdnud4vQ7MXHv8Ijt2fqIe4vggRJbu7VYgc86xEBdVVEn0VNXCyc49Jh6a1H+5E6HnMnyLFCcrLQWTagefyTIJa6ph/GptpKg4wwPPxlcYECa/hBbD5Nu4ZxspaXbFKERk0cCrjGYVc3RdRHSCYPk87oAEdJcupZwfzS9r6cSTCEEZsScM52rX+Mxb4XgtjLFpdXZtW4XPsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L88v0JQduFg1Aactd83eQ9lKeolN+STJ8d062QBCPNA=;
 b=Dms4Hna09DcewWCtnjkIwdGHI8iabp+ynTFjw0tVMxP3IAKSUSPZQrGwX6Ah6vWdWCPxY8iGLmEOXK7YWYh/Fr7hI+gPk5ZDgxbfKpvm/VxvIwDD0U++ReanSqQEFnMixxsjB/+7waywx3BjyGsmyU2mnSOC9QO4gYROZING82BEOIfIBeyn9V9nGJVfvXUem6CfG+kBMeriNYobDPpjI9KTvsQZvGcIxRE+lrqXolnjp2NgdbTUJPG7EpHr8CmJrIEZR4gSI5CIAwBGhGE5DCBMhUZnqBXAqESg+0rBtJU0eiTejgEVv8RONh9YQboOntKwvjYAuG7S7tI/rdCrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L88v0JQduFg1Aactd83eQ9lKeolN+STJ8d062QBCPNA=;
 b=fqsmh0DvKQi0A3Cz5cyPjbLcrWXFsHADIsozIrVQpBsRJnnPrtSI/m7nuRVxR8ywkoYlvzCV43VV7/+dGQUpSpPz7M/jeOOuY5jxu5LrKX5OasfjnWXYslh1qH9BoZXanY7F8WJ403HOi4QUH7ZeP439GPlG+dnnzm4fp8/fuUrcDiskkYdvGqqoFePREvYHMiDQx2te9MJOKU/Fg1lSw6RXWeI+GHnErOkNn58gvqdg/DhESQET7L/hMuJXRlbvEy4FNbuiRUOUNuUZ/Y2UWYq+ecQ3K/+J+ezJrxikx2KEPYlZ/HSMxcRoRRzWN7FuHOmZeGNOBR5qMjwMsg2cjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:29:33 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:29:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 11:29:32 -0400
Message-Id: <DKAB7XNPH1GY.3SQENETD9J2VX@nvidia.com>
Subject: Re: [PATCH] mm/filemap: __filemap_add_folio() restore index before
 retrying
Cc: "Kairui Song" <ryncsn@gmail.com>, "Matthew Wilcox"
 <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, "David Hildenbrand"
 <david@kernel.org>, "Kiryl Shutsemau" <kas@kernel.org>, "Chris Arges"
 <carges@cloudflare.com>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
To: "Hugh Dickins" <hughd@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <562fbfa6-dd6d-0b6a-2461-ed2ff1173bc8@google.com>
In-Reply-To: <562fbfa6-dd6d-0b6a-2461-ed2ff1173bc8@google.com>
X-ClientProxiedBy: MN2PR20CA0046.namprd20.prod.outlook.com
 (2603:10b6:208:235::15) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 716cdb10-f207-4f11-7ac2-08deecbd065d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bQ9Oxs+uDXoiWopRgetEaO3EPoZqbdgTqrK4qH4lZDToZgzxgMyU52O5ca7eQHF5hVI+rC/EucwAElCO9+DEjBSeipbj2v2zeLcIR5grf+SB45PdNf8RaUEynL7Lc1DxGpl/MilWeYwESvZlupfr/73z2t9pch6PWwpe4eoEPVe1UTrtPTBIe7mFQ8iuQmoXAEs7apqKqWXdmVVGwFpt8tu5GFBHkyU1OcUxstO1koclg7vMlFhhsTJ51h0HAtGRblRWsDOU6Fwe0ZHKBr3J0W60wVVl9Es3AcRirbnM1TIVdzt72Yox9Llbw75nLQuFHk1izLC3VCl3sVvdR7xf9a1HI5AfFcFe+4k7RxTWHSTvHxuuTZjSXKMUn3sf1HPzInEC/tVFGnXLBKjdNf+DBBoYasGXbLZiLa6ja8r55aJafP/k1mQTXa9tBEZ5BM/3LclTvop4wmFgxCkXRLx4SYrsFiaRnfDz+4Pkgy8ds0IMNtZzNknjNK589GCeghwM7ReuinhJxtMwqKfU6Ip7nBCmSJ7YbxrBHiqT88IGOeBEHOP8wkLcVpp5VoKtO1O0oczx5ocrrlNPe7dwaDn5Y5IZ6qBm7CK2BIKq0p27TIof/g2U546ncc72h727pzUuok//AqqWhSytr2in2XBbdVxi79USByjGCGZ1tGDNMJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1JVMzltVm5sdUk4VzRxM2pVNHNscjkwTythb0RXR1FBU2pmMkFpeDd3cW5K?=
 =?utf-8?B?aTlEd1pkTGoxWTJvQnRFVGFvQnpVa2JqSjZodFR3dWRkRHdrdmJxU3AwQVMr?=
 =?utf-8?B?UENvVFdDU2ZiMCtoNXZXakpjRlhZRXEweGFSSFh3SS8wN2xqYnZCL2lsSnJm?=
 =?utf-8?B?dTkvUjdsVGU5QVovZ2tEb1FndFc2aXh6dTFmSG5rSHlGRnc0dWF2NG84RmVN?=
 =?utf-8?B?aFNTaWdEOFlGTnA5V2hHUEJxRHNWaFYrVExwVUdZRVc0dXhEUUtQd1hHWmNO?=
 =?utf-8?B?VVBzQmJCTzJlazlnUTZxd21vaFFPanNsM2tENis2STRtR1RIMm5XaENUdU9h?=
 =?utf-8?B?YldGV216REt4VmxPYU5IanBkVWQyUkNYclZhWVU0TG9WTnZ5ZTliSk1BSXR0?=
 =?utf-8?B?VXBNRzV2MG1OSndYbTdTUlFvd1lPZ2lIMjcwVTlPTUtMU0tJQzExaFc1UjFk?=
 =?utf-8?B?bDdvdkpHcVZIeGFZdGRWYzlNL2E1Yk11NmxSbGlISXB1V3d6SGxTOXlla0g1?=
 =?utf-8?B?Y0hZaGZ0UEJiUW1aMjgrb3ZSVUZ5d1o5VzZFUzFoSGFhSjAwMm04YThGcm82?=
 =?utf-8?B?cGtQT0VDVmRSc3A3dlVHakZ2S0FSOXdDTUxKM0ptMklESVpqWm1saU51Vnls?=
 =?utf-8?B?R2RjeXl6cXhZNERhMkE2RDBPcURlak12NXordEorVG1DUDgrK2RNaVdpR2FS?=
 =?utf-8?B?ckl2VHAvUDFyZENQZ0Y3NkpVaFMvOHZLaG81YmdwVzZEV2t0Q1JDVm1FVlVm?=
 =?utf-8?B?Mml0Y1k5aXkzT2VnNDJhdWxtdGZLVWkyYjRYU1IyUEh3bzQ5d0NGaGFLRUcr?=
 =?utf-8?B?Q2t4WnhzbklNUStiM041RVA0bHNVdmg0clkwNGc2eFNoaDBncldpOGFIMTdX?=
 =?utf-8?B?NUZHNForQnlMblUyenVQNXRwZzAxY2lobFVBWkZ3M0VpdGxmWjdoTm5iUHFJ?=
 =?utf-8?B?M2Q3Ui80U2xuQlVObnlQODByVDFRbGdEakFGSXgxaVRqdDR5N2FHYlYrRTVm?=
 =?utf-8?B?L3ZPWU9mdXZQL1ZZRmJWY2lLUHdjdEtMZFUyOFlrcFZQZitJWUt3azFPQTAw?=
 =?utf-8?B?UHBqNS9EcVNlc1dBQ1IrNklYaW9GcS9YU1c2ZzVxbTJvL3hTdkdndHpLTERl?=
 =?utf-8?B?Q3c0cXluTlJGcUZiUWVCQzRHa1NhaS8zN1F6U0lQZGJpcStGOHk5WVcxeWZz?=
 =?utf-8?B?ejluM01GSWZrOUlEdGhLSVA0RVlNOFBIc3lPMlFoZ1BlMXFXcUcwN3M1SUdJ?=
 =?utf-8?B?by9jMVFETUhVUlkvaHBTNHdBKzhMWEFHMUJnUlRzOUFDTi9tUkZtTDdxNFBK?=
 =?utf-8?B?N2lxK1pzci9hTUhqVk1tbUtEQ1preUk4L3VYZkpobm1Db09pRWNPL0puUTBJ?=
 =?utf-8?B?YXZ5elcrWGt0Uk42SEtZbWdrcXpvVTNqVlhmcDNGNEZNbmdnTU03MjZhcXBJ?=
 =?utf-8?B?UlBYRVhUMlIzNFg3cFNkU1p3RC9rcitFTWEyK1pNQ3h6ZnZ2WVh6WmNJYXBl?=
 =?utf-8?B?ZkhZbjdmMXlOV1JONXNWajd6UHpiRDRBdWlJdTEvS1BSZUdDbEViKzhnbnRP?=
 =?utf-8?B?bmVBb0tmODNaZEZtaGlxcDNtQUczazVsTjc1TUtzNVl2cEF6cG1CbE5hRW93?=
 =?utf-8?B?UGpYRjNMc0gyWUtFOEpjd25TOXN3MXAyRFpIRXg0Zkc4YVJpVEdxamdDZFM4?=
 =?utf-8?B?UHJpL201TWROOXlpOVNVOXRrRlhieXk3RURwL2xScEdyWWkrQ1BtdFJkOFhM?=
 =?utf-8?B?RE9SZ2RXd0xreVRpSk8xMDg3eGoydnhrWmtPVEQ2a2hTQWhBZGFZWGMvYWJ4?=
 =?utf-8?B?UG1GQkdrMmpLaTJQLy9FUDd6RXk2TXVNT1BIbmJkQnN1MTFUWjRhcVk2aE9Z?=
 =?utf-8?B?anM1WkNSU241Ung2Z1FKdytVNEI0T2l5UEE1bkpWdFZ5VUdCdHRncUp4WW1n?=
 =?utf-8?B?OUIvZzhPamNtcnJNemoveDBxNlBHUEIzdjFqVGZUNGFjK1dmL2RCajVUY3hh?=
 =?utf-8?B?bWRtSVhXT0NCMFZMeDlaMFNsYnh1MTNzTTAycEhRaHdWUEdXTVhMSmNMQjlZ?=
 =?utf-8?B?Vm40U3pJb3puWkZVczZrM3lMVklNMWtXK24rclRzY3hvQjRCR2U4WFczbnNK?=
 =?utf-8?B?TUNKVmRUZkhJQThFYlFvT1V6bFF0OHFmSSsvcmJhQU5sVW5FNHkyaFVSd2Vh?=
 =?utf-8?B?OSszWU5vTmNKa2hNczV5L0R3L25Wa1ZhcHpaUG1paTlNUmdMMmZ0Slk0Z3B4?=
 =?utf-8?B?OEhvNFZTZDl0YjE5YWpPTldoeXJ2Y25Id3Rvb2tGOVlvb2RGd2pSTklmaGEz?=
 =?utf-8?Q?4N4TmzS0FKexxM1XGv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716cdb10-f207-4f11-7ac2-08deecbd065d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:29:33.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7dz2xnTOKb0NERFj0E+WyPym5j0+7iLzbd5ZLOEoMgCkqMiv0geHVXwitFwOJAI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

On Tue Jul 28, 2026 at 1:24 AM EDT, Hugh Dickins wrote:
> In __filemap_add_folio()'s split-a-conflict loop, xas_set_order() is
> applied repeatedly: each application modifies xas.xa_index, rounding it
> down according to the split_order attempted at that stage: and if all
> goes as intended, it eventually (or immediately) converges on an
> xas_try_split() to the required folio_order, with xas.xa_index now the
> same as index: then xas_store() puts the new folio into the xarray there.
>
> But if a new node was needed, and GFP_NOWAIT allocation did not get one,
> the lock is dropped, xas_nomem() used to allocate, and sequence retried.
> If (that part of) the xarray is unchanged when the lock is reacquired,
> no problem. But what if the conflict was meanwhile resolved by another
> thread (perhaps even doing the same thing, inserting a folio at that same
> index)? Isn't there a danger of now putting our folio into the xarray at
> an intermediate rounded-down index? With !folio_contains() bug to follow,
> when CONFIG_DEBUG_VM=3Dy is checking for that.
>
> Fix this with an xas_set_order() to restore the original xas.xa_index at
> the bottom of the loop, so the retry does a full re-evaluation after
> reacquiring the lock, and cannot reach xas_store() with the wrong index.
>
> Production was suffering from rare SIGILLs and SIGSEGVs, executable text
> found a page away from where it belonged, !folio_contains() bug hit when
> debug enabled: symptoms not seen since this patch went in.
>
> Fixes: 200a89c159a7 ("mm/filemap: use xas_try_split() in __filemap_add_fo=
lio()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/filemap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Thank you fro the fix.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

