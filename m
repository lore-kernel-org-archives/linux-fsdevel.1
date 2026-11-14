Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794697645;
	b=HifyUWmn6TP7lGRK87sJ5iAcVfaZqLMfq+AjzHLlWB+1raCrVzhcAsf3S2z42tjGuLMR
	 wH+gecQLkzLGSQCtTBEVYbF/tU4SSy9wCfEvZl7zUvxOHV0Oev7LUBMaRkp69i6dbafZ5
	 EOhO2TAFQpkx4TcspfNEOj2skI5K8roEsVG5XpcXkRBPiMz7XVImlwva27ZcFa4b9PFJi
	 G8sX0FnxQf+F6+Bihwnbk8KknQt738wWX8hqm1YKjHobWK0QkfM/EVXgcQS7N2bzxNwq5
	 7K5LXKG73TxtZKtDKPM0LHx2DmkNIZz90t/3jwXqlm62lOAhk8/qksEioO2eQaMnnSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697645;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FaJIor44vArmHaBOyjE7uNl90Va+Q0d0xwZX2SoxbHE=;
	b=e0c0sP/QXiwH/EN/644bKpZ/12Xst8ZmZtT+FIxgwGx0S/0LEpJy173EZzn0Fkow0fcm
	 9Vz1D210QC4od6kNa7kanTxGqsuYjNXBQ9HOHpQ5epSxfxMO5MCJlaxHq9ueVCi+8rPuL
	 JJP3mvSquTpWwcpmjlPue4/GpcIUalCaKdhNYnR819bTVqsnsEWBD7eCLLsE52IRZSaVU
	 viN5dx50gOXcKaWJK0K9wjItTcLZg/ke2bt2zp9zWyJkQ+lLSpXJ21sF3tCrT59Srbxn2
	 W1+zh3hSy7f6NSdK9FlrAEdCefQq6VpVPBMSYcX6nyiiu9b52Osv3kv9ctMQtNadLKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iUwMszJS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.34
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D4606A32E;
	Sat, 14 Nov 2026 23:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 034D4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iUwMszJS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEBsTWpJN84Whl6t48ifS2xecyoZ1tBeDIUYVdk71XEEKmnVWBhR0LX8XNQhd/njmjl2SEeEiGprlxz8VigaYhpMzVES/wQNuZqoSyQPaw5gi/HUDs6bcFCEmQ7LPoyiiY+EDvm6G2rTaQJEV1dikTwDyN/kRPDi1r29IjmrxA0FDEuK3KDyoL+9Vb69dLvnJLFseXrwiWk1ZDcfb4rOU4e7IuLNT8d+OsMOyiIliXcl5ar/1gkP/jz2PaFYvFuUP7lkxSzDLejYOJU03pMktDTr8GJPmwoCTvUsvHYZiXvxYwQridT5xSFkKUiHAXDCxh0IovXDUylDqV9yn+C4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaJIor44vArmHaBOyjE7uNl90Va+Q0d0xwZX2SoxbHE=;
 b=pya4C1m42lUbooliLKYLdY0w1t5Pa8NJ5x8PKm1ZMsLQv6siO7QpYM22iKffXsnb5m0+jfyZIzopPb/0bDShg2diBOZwSMw+Ma+0Vk59+EFzy1iHTWwjJRRak3Rp+q6vAwGXLzZ7Ad0EByOr3YkLNnIl+r4LWM4PZ7iZD9oRTX38ZSCb78m1Z4b1QcJFOZzD65ivkItSsQVFvIvgpgF3F4E5oMN4S/dblZ+T0IxMHGZZy5kM7vpFUfxUEJDwEPUyusipW7J390zeXSckUzfTsPbVhGL2TSQK1QnK1aOhUYt0YsEfVypR1QmfCXTaVXBBXS7VxosRHlQBjHHa29Gz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaJIor44vArmHaBOyjE7uNl90Va+Q0d0xwZX2SoxbHE=;
 b=iUwMszJSQvxx8JRru+qBh2TCeEcw8zQ5ha8gIlz/0D7s+ff99r//6XCd7FhNOG257ubeQTBgZSQsFbQvGqYFeebYXTSpehZlDqWGPf2C7/lQpWTYw/47BRzQyN4f4VocJ+fjJy+kIPvMEvdHKg29F/dR4WdWBJJEfz3qySTGXStKsh5rQ4oAjTG72GlDWjll3sALDQnarpAv/9nSr3BuxBDX6P+1Nt1j9a4SlAmSfU2mhNtYDvhgUabxquX43P4SMOSwIpBE6DlfoG9ORg6Y33zua69VHTmJ+//daKTqKpssPnw0beoV8NTHUO+o6JnLqvmDdgSfd0utiWM+tqsz7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by CY0PR12MB825472.namprd12.prod.outlook.com (2603:10b6:930:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sat, 14 Nov
 2026 23:07:20 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0615.012; Sat, 14 Nov 2026
 23:07:20 +0000
Date: Sun, 15 Nov 2026 10:07:15 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 13/13] percpu: queue the balance work on an unbound
 workqueue
Message-ID: <avjn4xuxUmtTfMWu@parvat>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-13-50a2ed382b61@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-13-50a2ed382b61@kernel.org>
X-ClientProxiedBy: ME3PR01CA0031.ausprd01.prod.outlook.com
 (2603:10c6:220:19f::12) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|CY0PR12MB825472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d16f394-9036-4877-1a0b-08df42a40929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	dEYNAQLtpHrxw9OTC62UNqWF12tHUv7w3jUAdVIJV5+P4ZroOVm6PAQYgRXYPzEq44/gPpMrXQmCD40nR5Hh0pSM8BEIPRjBrFpQ1evdV/b3NVWlHGYGO0xZ5K28bAxRbxc4jIJ0vm2xBD3hjZ7phjshW8xO3KegMGpJ0hbAKd3B3/kFGKt7VGanoGHGy0fVk01JToxKgUai2O/bXeAqza2Omk8OuNlBnsLIFq4ALieDnspnv9Gs3ZkFZ/E6+dmnGWmnD/2wrfrCZfYArS1OP2Hd1J8wyFH8arvHc7Bmn1Yeb1GLeXxN7LKjDkrBKAsUxu+2YjZ6JK8MJ5+0ozeMpKvzKCn/jO98cCiyIhmVuwPOerFqpOPjI0lo6QMS+TILk3oz/+fNQ6h0uZkKX/ZMdMH+z/iuvViBRqNiWFhGNwFGIVK+2FDILOeTIAqGqgUUjKnVKYlI2hsMnfeRBhXeRs4m9BQNcIvh52YEe1bcFFyz07kEwkvBoF4Cu6rrZ1/PyxGhU7NmaKmjuJo79PR6pIdBCEjikfgik9juXD0fUNN9mrpqx7rM2szakWFtdffo0X3eswZD+sKLcoXpXw4vGN9uZQDWDqTJkp7v9QZWB+YURepydaMouoa6TLBcu5+TfIxCR6EtqnVLRA+EBZv2L6i6AF0DeCmozZU0HBZgsvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SST3E/QV9k/3T28hUg2JU/RK/HbphONz2P61Tjpfsuvze4iWjyVb/S+3t2x2?=
 =?us-ascii?Q?POZnDCdN6hAS8BdxqJMWFpNMk3Um/YzPjYvPY73BU1MEWzgTcWzvs72gneqq?=
 =?us-ascii?Q?z1VMRmjCilwzCZXMM+oHxLm4FHB03Dvi/Ri/dwpgimEV+REhfnIOEmaurn6Z?=
 =?us-ascii?Q?pgWoVJceR9kdT7uKh3KBg4+QnFuLMYKWKH1NlPNNarbidh09P7KWnFsdOiML?=
 =?us-ascii?Q?IZYeSi7kTDQ8Q9M+0wpcNj0gw6TvSNSHTD+TGwt2KBMVpdIQuIZvoiC/n1eA?=
 =?us-ascii?Q?EhPuQXAP6274nMwBQq8p2w5gd292FYbGtQ3TeiogQFElKSVnNcr9IAwfZKDk?=
 =?us-ascii?Q?J4yrNc28VyR7n7lr14NO/3dgAIG6w8xqhOeoZ8JV/DV6aqyVNmllkydMqtvA?=
 =?us-ascii?Q?M0Ox001BarA1fUWBAd3DTWXdC0UdutJ6UtJ6AF1YXIHpvQu0b1fmhseO1DP7?=
 =?us-ascii?Q?Nx7G8cXjHiH449PF9QVhjNCuSj73CauRFtOr+K6NPSwU6IR5o6BlZItlAPmd?=
 =?us-ascii?Q?8HtWvLU0Kd6mfrA7nsuOOfXs+tNBPaEWf6sfumQww3m2punv/FwsF/zkzj3q?=
 =?us-ascii?Q?zVopsDxwn3exsIPFNzBKtO0vwPToRGmjBgx2ZePNTe2A4t+dD2JD0ErTLdGL?=
 =?us-ascii?Q?XU+38PXy1k7EWXKrZOpE5oGZap3WXbGoYmRg9nE9hxPAh3PG3imcMUOqXCxE?=
 =?us-ascii?Q?PI6BKjfi4+OjM7f1p6rMj6N6ZCxXWjCHdWIUKGdpvvQ1Aww75AKLePylPBiL?=
 =?us-ascii?Q?uar4izIeUM0TTpqHewmElK5vuMRY/HNt/9B2JzeUcVTpxsyZv4t5iOdJf9EV?=
 =?us-ascii?Q?sayoMbiMp9UBAbdggmhyaNJaxBUpbz5HUzQw3iWvWfU7t3jrbrPFElyite9i?=
 =?us-ascii?Q?uRqDCubA6dpc22nCl+SpSFjvX9cn6q5T8ze67sFrItYNTKQM3gUigXo9Txb+?=
 =?us-ascii?Q?ojNvgYlU2RLvFgIRii8uX/0vZBQsDPFnyfQ7NMFxbrNpwqcuaGt/mhGkprNc?=
 =?us-ascii?Q?A6FVH/tRfOoUnbmsIs9odkPCIBlwuNA8BwNmKdJaqgMaItFrR16TmSs6KbNV?=
 =?us-ascii?Q?atEa0A1PQGR6ye7w40axoss2Z9n0TV8OB7yf8LKqboDQGQadjBbyDFdXFRqW?=
 =?us-ascii?Q?u8U7ZexKhLGMtV+EGMQYdtogXAJUELNuuRnWSjmmd7DHnXUGFAcNjrHRY0sj?=
 =?us-ascii?Q?vQTrqLhOtCau94d6lr7BEzW/t8V16sPbIdnLw3wizBIOhRmj9bmNCvfHLXs8?=
 =?us-ascii?Q?B+QiTyyjRQdN/FXqcLqGYV78mqK+9UZdLoewlWrVD8sl8mjxxlkOrot79RQg?=
 =?us-ascii?Q?Il9i8KG8lgUkBmqohWXFzya1hfSHNekhsZoxAqDfLbZCSSUS55NPquVX5uhT?=
 =?us-ascii?Q?lOiMQ6cAYO5TB1MCJfwc8m2hyAsVnfAaIVhaLm8JkMrG3u0CKeBNpez6QZrG?=
 =?us-ascii?Q?HhwygP9iu3gkbcAyjJEWaPeg8EFkk4ypMb3Zt7SAzeqOITOJB6xlKSZsk4Q/?=
 =?us-ascii?Q?oIZ4t66jNlKJDoLxd4oRTswKuN+IS6kLSpa7OWsXSfQs6y06ywljXcDVZPqQ?=
 =?us-ascii?Q?sOiGRjs0Ef6D3MsZbL9JVDNxVFQSwmVaMKFokEcWHZcEU9tfnEeG2M4zCsXZ?=
 =?us-ascii?Q?ZVYYkWHwUAeB7UNFbe94oG3A7zE5uCqMZb5ECGb02/IFZFQxktxmwLzbPWPT?=
 =?us-ascii?Q?PMIDa1S/feb9aXl0hN7bvSXTby6P9aGi4EFFpIMgoT0VzQnB3EWw4xpR0pj4?=
 =?us-ascii?Q?CmC+eet1nQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d16f394-9036-4877-1a0b-08df42a40929
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 23:07:20.6849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA3FdzqOm0pMj5AnetTj2SXuPbR2JCFsdDJt7U91WG6/v0YG0GJ+hdjWMGysB7GxeNAESfh3DB9MTpg7q9ykLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB825472

On Fri, Nov 13, 2026 at 09:45:31PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A burst of small atomic per-CPU allocations can fail with -ENOMEM while the
> machine has free memory and idle CPUs, as atomic per-CPU allocations are
> only served from pages that are already populated, and those can be used up
> before a worker gets to populate more.
> 
> Consider:
> 
>     caller on CPU 1                     kworker bound to CPU 1
>     ===============                     ======================
>     allocates 8 bytes, which leaves
>     one empty page and 4088 bytes
>       schedule_work()                   woken, waits for CPU 1
>     allocates 8 bytes, 1023 times
>     next allocation: "no space left"
>     gives up CPU 1                      populates pages
> 
> The allocator keeps a few empty populated pages in reserve, and the work
> item pcpu_balance_work refills them.
> 
> pcpu_alloc_noprof() queues the work item using schedule_work(), so only a
> worker bound to the CPU of the caller can run the work item.
> 
> The issue is that the caller keeps that CPU - a task keeps it for the rest
> of its time slice, and a softirq keeps it until the softirq ends.
> 
> In that time the caller can use up the reserve, resulting in an atomic
> per-CPU allocation failing.
> 
> Fix the issue by queueing the work item on an unbound workqueue so that
> another CPU can populate pages while the caller keeps allocating.
> 
> Gregory Price hammered atomic per-CPU allocations from one CPU with
> preemption disabled for about a second, with and without this series:
> 
>                            Before     After
>     Successful allocs       1,188   131,072
>     Failed allocs           4,097         0
>     Balance worker runs         0       169
>     Successful retries          0     4,096
> 
> Fixes: 1a4d76076cda ("percpu: implement asynchronous chunk population")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: tweaked commit message, comment ]
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/percpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index f87813e6ad73..39cba1710383 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -200,8 +200,9 @@ static bool pcpu_atomic_alloc_failed;
>  
>  static void pcpu_schedule_balance_work(void)
>  {
> +	/* Unbound, so another CPU can populate pgs if caller keeps this one. */
>  	if (pcpu_async_enabled)
> -		schedule_work(&pcpu_balance_work);
> +		queue_work(system_dfl_wq, &pcpu_balance_work);
>  }
>

Can this run havoc on otherwise idle systems? Why not choose a workqueue
with WQ_POWER_EFFICIENT, which becomes unbound when nohz_full is
enabled? I guess it still leaves open the case when nohz_full is not
enabled and we get a burst of atomic allocations?

Balbir
