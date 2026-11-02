Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634053;
	b=eBRiCa60joCnnQxZbuYQWpiPMnVtct/WVkez36SIJgujptr4QFFJxuk713EZM9GKhl6E
	 0oKWrxCV/UV/Me7Ih6UT3hG++kwMFI5TbI8zB6HJA06MRLlDtDKfZNvyQBDhmZFDxm5On
	 nsINsPplJWWFrQ1pnQU5kFx+Fixt+9S57R5GSYR0TkK1kPsufG8S6x8mI9qrwConHd166
	 jauwX8ksQNIz94YzUEaUz+ut2Zu52lyUKjAXB6eyhCJlUjkFWIYA1D0ZjNOqAY9sQnToT
	 T4N1XE10AM3E8qUZxbXL0I7hzhQZA5tvKSqH05FNbQIMx7pn+segCtxxsz0V7Bed4Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634053;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=C+xl5OHF774uZtOPJCxbupJhSCVj7T1aesHy1KgIPVQ=;
	b=ydoUC0QnxMXoW8wPq+rs2OwSH3WOcPZZS/f0l4TnH2NElH+E2z8/nYB0ffGyEHMFvNzr
	 AvVCSqX2Zlr0SsK89jXj9/Q533PErUXpocdtQmjOpaW7gldIY5mnM18f9Pve9+N7kP6Rh
	 VyY48pr+lCrwYTFFwv6CeBg5wNEO3oMZnuz4gN9MWK0tUCCA3wURNmDFN1rmujHZkGdqL
	 3L1Lhn9OAdmI1XZDDax1QTcRt/9Afyr3x3+z37pzu9j8PAxm+MYqJ6+T6aEF2xhZJXmdp
	 Vjj3E6AL6zeqPjfWS+lupyLnY0+nEVD+apl8bq6lwDNrUxdebDfK8JroCFpRfyhpxXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Befe4p1s;
	arc=none smtp.remote-ip=91.218.175.228
Received: from mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201A606B1E4
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 15:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B201A606B1E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Befe4p1s
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2RxZ1Fiv8HmDPeSkPRWplPA67yOwGmzkE3Pmd5fIgAI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793634049; v=1; x=1794238849;
 b=Befe4p1s1dPV5wEiiN8VWowjJohaMdYgChQo2iReBi/0naWhjWv1f/cMbznBmFtJkfGK3zaW
 sg/iS4v9W3nC582Nm2KLjQqbGjoDmAyxg9QyG2N59s/+ESRN9/yn1H2/vz34Id+oUutKCQeOXuA
 JvvTAheFKUgnF0fsy75lHPxI=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e5b9646824930c3;
	Mon, 02 Nov 2026 15:40:49 +0000
X-Mizu-Trace-ID: 2e5b9646824930c3
X-Migadu-Flow: FLOW_OUT
Message-ID: <0316f664-d98c-43be-92af-13c30436727a@linux.dev>
Date: Mon, 2 Nov 2026 23:40:40 +0800
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
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
To: David Laight <david.laight.linux@gmail.com>,
 Joel Granados <joel.granados@kernel.org>
Cc: Joel Granados <joel.granados@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1793204511.git.wen.yang@linux.dev>
 <20261029105837.2f8bee67@pumpkin>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20261029105837.2f8bee67@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/26 18:58, David Laight wrote:
> On Thu, 29 Oct 2026 00:34:39 +0800
> wen.yang@linux.dev wrote:
> 
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> struct ctl_table describes an entry with data, maxlen and, until this
>> series, two untyped misc pointers in extra1 and extra2. Those two pointers
>> have accumulated at least seven unrelated jobs: a fixed bound, a bound read
>> through a pointer on every call, an object or namespace pointer, a small
>> integer cookie encoded into the pointer, a lock signal, NULL standing for
>> "no bound", and a value the core itself casts to unsigned int while
>> validating a u8 range. Nothing in the entry says which job applies, so
>> readers infer it from the handler, and the core gets it wrong where it
>> treats extra1 as an unsigned int.
>>
>> The numeric half of this change is the direction Eric Biederman asked for:
>>
>>    You can still save a lot more by turning .extra1 and .extra2
>>    into longs instead of keeping them as pointers and needing
>>    constants to be pointed at somewhere.
>>
>>    [...] I don't see any reason why you want shared
>>    constants for such a handful of things.  Especially when
>>    it has proven to be error prone in the past.
>>
>> min/max are plain unsigned long members, so the comparisons are ordinary
>> C and cannot be confused with a pointer. The shared const arrays that only
>> existed to give those pointers an address (sysctl_vals and
>> sysctl_long_vals) are removed as well.
>>
>> The tree already records this direction. fs/proc/proc_sysctl.c documents
>> extra1/extra2 as "extra pointers usable by the proc handler routines" and
>> carries:
>>
>>    XXX: we should eventually modify these to use long min / max [0]
>>    [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
>>
>> This series completes that TODO and removes the comment.
>>
>> priv is this series' addition: the same pair of fields also hides handler
>> context, which a numeric bound cannot express, and keeping it out of data
>> is what removes the restore-before-delegate pattern.
>>
>> The overloading is also a memory-safety hazard. The obvious alternative --
>> keep handler context in data and restore the value pointer in each handler
>> -- needs an original_data field in nine addrconf and two devinet handlers;
>> one missed restore turns a user-supplied integer into a write over a kernel
>> pointer. nf_log reaches the same problem from the other side: it replaces
>> data with a local buffer inside a single handler, so data means two things
>> within one function. This revision removes that temptation instead of
>> managing it.
>>
>> The core is not exempt. sysctl_check_table_array() reads
>> *(unsigned int *)table->extra1 to validate a u8 range. That is only correct
>> while every u8 entry happens to point extra1/extra2 at an int or unsigned
>> int; a long bound, a context pointer or an encoded integer would be read as
>> four bytes of the wrong object. No such entry exists today, so this is a
>> latent class rather than a live bug, but the invariant is untyped and
>> unchecked, and nf_log already encodes an integer into extra1.
>>
>> The refactor is the first five patches; they define the replacement
>> contract and prove it covers every entry shape the tree uses today.
>>
>>    1. min/max hold numeric bounds by value, and priv holds handler context.
>>       The range converters read min/max whenever extra1 and extra2 are
>>       clear and keep reading the pointers while they are set, so existing
>>       callers keep working while they migrate and no parallel handler API or
>>       renamed symbol is introduced. Signed handlers read the bounds as
>>       signed longs, an absent endpoint is the type limit rather than NULL so
>>       zero stays a real bound, and a run-time range is refreshed before
>>       every call. Registration rejects priv on a standard handler.
>>
>>    2. The debug test module is converted to numeric bounds as the first
>>       user.
>>
>>    3. KUnit coverage for numeric bounds and the handlers that consume them:
>>       full type ranges, one-sided and zero bounds, entries without backing
>>       storage, explicit handlers for arrays and members, and rejection of
>>       writes that would partially commit.
>>
>>    4. KUnit coverage for run-time ranges across the scalar widths and
>>       jiffies, run-time bound pointers, sibling bounds, typed context, owner
>>       derivation, bool, registration lifecycles, and simulated per-net
>>       duplication.
>>
>>    5. KUnit coverage for priv: a standard handler must ignore it,
>>       registration must reject it with a standard handler, and
>>       re-registration must keep both the value pointer and the context. The
>>       same patch moves the debug module's dynamic-value entry to the
>>       data/priv shape.
>>
>> On the CTLTBL_ENTRY_* constructors: I kept the naming and argument order you
>> suggested while reworking the series. As it turned out, no production table
>> needed them -- the converted entries read naturally as designated
>> initializers -- so I have not introduced them as a public API in this
>> version; the KUnit file keeps an equivalent constructor privately, so the
>> tests stay readable. I still think the public version is worth doing, and I
>> would be happy to send it as a follow-up once there are real users, so the
>> API and its callers can be reviewed together.
>>
>> Everything after patch 5 is migration and adds no new contract. Patches
>> 6-32 convert the remaining users and derive owners from their backing
>> storage. Patches 33-38 move handler context onto priv, one subsystem per
>> patch; each of those files is touched exactly once and goes straight from
>> the old pointer field to priv, with no intermediate data-as-context step.
>> Patch 39 removes the extra pointers and the compatibility read.
>>
>> The parport conversion illustrates a concrete problem with the overloaded
>> fields. In the base tree, registration overwrites the spintime minimum
>> pointer in vars[0].extra1 with a port pointer. The range handler can then
>> check a write against data from struct parport instead of the intended
>> minimum. Moving the port context to priv and using numeric bounds also
>> corrects this existing bug. A separate fix can address it independently;
>> this RFC does not depend on that fix.
>>
>> Entries that used a *_minmax handler with neither extra pointer relied on
>> NULL meaning "no bound". They now state their type limits explicitly to
>> preserve that behaviour when the pointer path disappears. These include
>> aio-max-nr, acpi_video_flags and nmi_wd_lpm_factor.
>>
>> Owners that can still be recovered from data are deliberately left alone:
>> ipvs, neighbour, the fragment reassembly handlers, vsock, mptcp, rds and
>> smc keep using container_of() on their backing storage. priv is only for
>> entries where no such derivation exists. Mixed placement in data and priv
>> was considered and rejected because it recreates the guessing problem this
>> series removes.
>>
>> Relative to the base tree, the final state removes all 841 extra1/extra2
>> assignments across 123 files, removes the shared sysctl_vals and
>> sysctl_long_vals arrays (21 references), and states bounds at each entry
>> (~574 new min/max initializers) instead of pointing at constants. The
>> sysctl ABI is unchanged; the parport spintime minimum is corrected as
>> described above.
>>
>> The cost is 8 bytes per ctl_table entry on 64-bit (56 -> 64) and 4 bytes on
>> 32-bit, because priv is appended; the range read path gains no indirection
>> and the migrated entries no longer dereference a bound pointer.
> 
> Can you remove the little-used 'priv' parameter by making the extra
> information just follow the table entry (nested structure) and have
> the relevant functions use container_of() to get the outer structure
> and extra values?
> 


Hi David, Hi Joel,

I reworked the context side of the series so that priv is gone entirely;
and the final tree has no per-entry context pointer.
A small helper recovers the enclosing object, but it needs the slot
index from the caller:

   #define sysctl_table_container(entry, type, member, index) ({       \
           static_assert(__same_type(*(entry),                         \
                                     typeof_member(type, member[0])),  \
                         "pointer type mismatch");                     \
           (type *)((void *)(entry) - offsetof(type, member) -         \
                    (size_t)(index) * sizeof(*(entry)));               \
   })

The reason plain container_of() is not enough is that the core keeps the
table as a contiguous array.  For

   struct addrconf_sysctl_table {
           struct addrconf_sysctl_ctx context;
           struct ctl_table table[];
   };

the handler receives an interior entry, and

   container_of(ctl, struct addrconf_sysctl_table, table)
       == (char *)outer + index * sizeof(struct ctl_table)

for ctl == &outer->table[index].  It only returns the outer object for
index 0.  Passing the index explicitly keeps the original registered
entry usable:

   static int addrconf_sysctl_forward(const struct ctl_table *ctl, ...)
   {
           struct addrconf_sysctl_table *t =
                   sysctl_table_container(ctl, struct addrconf_sysctl_table,
                                          table, 
ADDRCONF_SYSCTL_FORWARDING);
           const struct addrconf_sysctl_ctx *ctx = &t->context;
           ...
   }

Shared handlers get one wrapper per slot; the common body does not need
to know its position:

   #define DEVINET_CONF_WRAPPER(attr)                                  \
   static int devinet_conf_##attr(const struct ctl_table *ctl, ...)    \
   {                                                                   \
           struct devinet_sysctl_table *t =                            \
                   sysctl_table_container(ctl,                         \
                           struct devinet_sysctl_table, devinet_vars,  \
                           IPV4_DEVCONF_##attr - 1);                   \
           return devinet_conf_proc_common(ctl, &t->context, ...);     \
   }

Single-entry tables simply use slot 0:

   struct devinet_forward_table *t =
           sysctl_table_container(ctl, struct devinet_forward_table, 
table, 0);


The series is 20 commits over 134 files, with no priv at any point.  If
you would prefer a different shape for the helper or the wrappers, I am
happy to adjust it.


Thanks,
Wen

> David
> 
