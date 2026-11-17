Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934915;
	b=ZGyIK6JZCxc4zw0BoPArU/5s7u9VDNGbIqyeUn6VjIZeUiwpLBSfulnegisRp7JquhVK
	 n/4ovcYHtt3fckKiqXFCWjl0Js7BFeQcsPismnFBec25VRfAl5toNym317lXzxhUyjEK7
	 l+hi7EN42+NAxg4SWhcrACBn+IFxVXD1EcgHbahqyh7jkGZSyQ6K623ShiYsqB2nXD5hT
	 FBVVN72dSkXzk/Wqw+QNE6TbcsCeSjSOrS30X7fhnGif2KTCgOiDSHp7s7UH+PgAz63cu
	 SNKK7rYMJ4M4BwIglWJaVm5TcssGhdkSvwzRwuUTbpFzKZanLoMOZxwZ0Y5bYKvg1+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934915;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CkHa2sFv9CmQESaVn3NPFW88v6+W45HqsS/ucIanDx8=;
	b=5fe4g3f6adxuAeK46xl66W34e0GiIKQVZ4keRGbQUIy68Ztv47FiVIU2H0l/Aqf++BWj
	 e2w6/3JM/f6utRNS/iQ7W/L2KJlHFf4rjG0isAumpQbqUa8Bw4malRSjMnROmpjpkJn1P
	 YRUowCohV4VpteKUrTyV/iIN3xHlOrn8I6CBbkXya6dV4H5HPKhPt7tiVh4yGRDXZK9Cy
	 Slj+8ZFc074PoXnUuQs9Tevv9WZf+U3nwGxMA428T5yJYHGCmbOj8ojyZUSClSopYIfxY
	 lNwr/6qkz8F4WpAVDwQDC8ipTqp2ZS9E5pzHQ0oSCqZY9Ca5ZfsL7aDqDTPCTIlcOUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YUZwXye8;
	arc=none smtp.remote-ip=91.218.175.172
Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF554606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF554606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YUZwXye8
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Gn/OQQirr7fE8T3D1Iz1+Zh6kVmd5Ou8RsWt2FanJao=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794934910; v=1; x=1795539710;
 b=YUZwXye8jsajGNx6LtDcCC2bV5cwvznLc10tDGC/M3MaMLFmNbXMF+gcfUKvwkfR2XTm0ea1
 8gOqsQnJ+dusdv+E9WGjtRnlVaiAuumM3ByTTiaruPLVmajIf41tDob2K+wMlcuA0TkBnROsM1r
 2dWh1RAuFzups4rUDgolr/Qk=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7457a07eb241923;
	Tue, 17 Nov 2026 17:01:50 +0000
X-Mizu-Trace-ID: e7457a07eb241923
X-Migadu-Flow: FLOW_OUT
Message-ID: <a66d0c11-f13b-42ec-8ddb-2cbddf50682b@linux.dev>
Date: Wed, 18 Nov 2026 01:01:46 +0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/6] sysctl: replace overloaded extra pointers with
 typed bounds and core stride
To: David Laight <david.laight.linux@gmail.com>
Cc: Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1794844686.git.wen.yang@linux.dev>
 <20261116214023.1a1b4205@pumpkin>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20261116214023.1a1b4205@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/17/26 05:40, David Laight wrote:
> On Tue, 17 Nov 2026 00:07:32 +0800
> wen.yang@linux.dev wrote:
> 
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> struct ctl_table has long relied on extra1 and extra2 pointers to serve
>> multiple unrelated duties, including range limits and caller-specific
>> context.  This series addresses both:
>>
>> 1. Replace bound pointers with plain unsigned long min and max fields
>>     directly in struct ctl_table.
>>
>> 2. Replace per-entry context pointers with a core stride mechanism,
>>     allowing callers to register arrays of structures embedding struct
>>     ctl_table and recover enclosing context via standard container_of().
>>
>> This RFC focuses on the core stride infrastructure and two representative
>> complex users (netfilter nf_log and IPv4 devinet), as suggested by Joel
>> Granados.  The remaining treewide callers are converted in a single
>> squashed commit to ensure the tree builds and tests pass cleanly.
> 
> I think I would have tried to avoid the indentation changes - just to
> make the actual changes easier to see.
> 

Good point.  Looking closer at Patch 4, keeping the original
'static struct devinet_sysctl_table { ... } devinet_sysctl' layout not
only avoids re-indenting the 33 DEVINET_SYSCTL_* entries (cutting the
diff from +104/-86 down to +41/-23), it also fixes a bug where
kmemdup(&devinet_sysctl, ...) was copying a bare array into a
struct devinet_sysctl_table that starts with sysctl_header.

With the original layout preserved, the table definition change is just:

     static struct devinet_sysctl_table {
             struct ctl_table_header *sysctl_header;
    -        struct ctl_table devinet_vars[IPV4_DEVCONF_MAX];
    +        struct devinet_sysctl_entry devinet_vars[IPV4_DEVCONF_MAX];
     } devinet_sysctl = {
             .devinet_vars = {
                     DEVINET_SYSCTL_COMPLEX_ENTRY(FORWARDING,
...

> ...
>> 4. Baseline rebase & conflict resolution:
>>     - Rebased onto next-20261111 (aaa2f954c21b).
>>     - Added proc_dointvec_jiffies_minmax and proc_dointvec_ms_jiffies_minmax
>>       to sysctl_check_table().
> 
> I didn't spot those in here, but are they even needed?
> Without the bounds don't the minmax variants behave like the original functions?
> So it was only necessary to add support for bounds to the existing functions.
> (The only think that half makes sense is if a caller uses extra1/2 for
> something else.)
> 

Sorry for the confusion: I omitted the squashed treewide patch (6/6) 
from the v2 posting to keep the mailing list traffic small, and that 
bullet in the cover letter referred to a change in that patch.
I have moved the sysctl_check_table() addition into Patch 1 for v3.

proc_dointvec_ms_jiffies_minmax() was already in the tree, and
proc_dointvec_jiffies_minmax() was recently added in linux-next by 
commit 75f5722df2b4 ("net: restrict message_cost and message_burst to
non-negative values").  You are right about the historical reason: the
separate *_minmax handlers only existed because callers of 
proc_dointvec() and friends could stash unrelated context in 
extra1/extra2.  Once extra1/extra2 are gone and bounds live in dedicated 
min/max fields, merging the *_minmax variants into the base handlers 
will be a clean follow-up.

> Related, I think you can reduce the size of the final patch and the likely hood
> of some silly errors by making the 'dointvec' functions treat min == 0, max == 0
> (ie no initialisers) as 'no limit' rather than 'only zero allowed'.
> 

There are two reasons why treating (min == 0 && max == 0) as "no limit"
in the *_minmax handlers turns out to be problematic:

1. It conflicts with dropping redundant '.min = 0' on signed handlers,
    and does not help non-zero lower bounds:

   - Most proc_dointvec_minmax() callers in the tree only set
     '.extra1 = SYSCTL_ZERO' (with .extra2 = NULL) to reject negative
     inputs, i.e. [0, INT_MAX].  Once we drop the redundant '.min = 0'
     initialiser, omitting '.max = INT_MAX' as well leaves the entry at
     (min == 0, max == 0).  If proc_dointvec_minmax() treats (0, 0) as
     "no limit" ([INT_MIN, INT_MAX]), all of those non-negative entries
     silently accept negative values again.

   - For entries with a positive lower bound and no upper bound (e.g.
     '.extra1 = SYSCTL_ONE, .extra2 = NULL' -> '.min = 1'), min is non-zero,
     so a (min == 0 && max == 0) check does not trigger anyway; omitting
     .max leaves max == 0 < min and rejects all writes.

2. Implicitly defaulting an omitted .max to the type limit is fail-open
    on handlers whose whole purpose is range checking:
    Under the old "extra2 == NULL means no upper bound" rule, several
    *_minmax entries in net-next had bugs fixed just in the past two weeks
    because .extra2 was left unset:

   - 850a7225bc61 ("tcp: limit tcp_tso_rtt_log to a valid shift count"):
     tcp_tso_rtt_log used proc_dou8vec_minmax with neither .extra1 nor
     .extra2 set (so both defaulted to NULL -> [0, 255]), allowing shift
     counts >= 32 and triggering UBSAN shift-out-of-bounds in
     tcp_tso_autosize().

   - 0bc7b5b2985f ("ipv4: restrict igmp_qrv to 255") and
     6d6bdc1b943c ("ipv6: restrict mld_qrv to 255"):
     both entries used proc_dointvec_minmax with '.extra1 = SYSCTL_ONE'
     and left .extra2 unset (NULL -> INT_MAX); writing 256 silently
     wrapped the backing u8 field to 0 and triggered
     WARN_ON(idev->mc_qrv == 0) in mld_query_work().

   With an explicit [min, max] closed interval, .min defaults to 0
   (matching non-negative inputs), while forgetting .max on a *_minmax
   entry leaves .max = 0 (fail-closed, immediately rejecting non-zero
   writes during testing) rather than silently allowing up to INT_MAX.

To eliminate the risk of hand-written mistakes when converting existing
one-sided entries, I will updat the coccinelle script (Patch 5) in v3 so 
that whenever an entry uses a *_minmax handler with only a lower bound 
(.extra2 absent), the script automatically supplies the matching type 
maximum (INT_MAX/UINT_MAX/ULONG_MAX/U8_MAX) according to .proc_handler.


Thanks,
Wen

