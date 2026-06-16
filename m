Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F413D525E
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633402; cv=pass; b=E2CRdtShuc1PVd8D4URNoCTInsTcHUCHIrjosEkrqYdLtSGyrHUddwV3xD1AjOQYlt9fPmPkehsZkctXhvYkOBX3lP87gg/YQVuo6XDZq5MDm8+iipsuwFomvqV2OWCUgtWAHlgfT2bmGcX4sdK/y3g1RrUk6rzlo5WJ6lDEJBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633402; c=relaxed/simple;
	bh=hbZ7AtqKeATB2r4kr93uGgpM+Y/zj6+leroFxw5uOv8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mARvxXTcT0/GAooakcWVe8PfJvarksBQaFEjlToPED4AelVkwNmr7hqGU4GdsG4/dxRh2EJTpw/XB4MEIEVtOUT9ztp5qUSMCei4IzVieW4j92cSQOksk/xA6wXzdi0lRusKhuLOYNflpfSmRfWO/o3x4IAvjSMeDobwo4/3wFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXYp3gXJ; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXYp3gXJ"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1370417c01cso6355293c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 11:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781633400; cv=none;
        d=google.com; s=arc-20240605;
        b=gH4wDlSLW06/tv9tA2JE7YIPAcuBp1/IxfGojcN/wdg0E0MlHFLBXRBuVStXPwrxFo
         mqmWl6XcniXMY7VPHlm/1H6I5rtWV4nIVrnm0AZBf83CQyGuBwTs1LW1nyez41SSQV9u
         TlFkIdl4SNuMFi4WAR13oWkOA1sUN+sgOxVWF8E+o95rTXd4FmRIKgIzZMa23/h6SUWu
         p/KUFQ8Mxptr+Ll734RLq4x/nXmTzxY5KuGLVKRNrpNcZ712AN14Qmo3d1TnH9/5O3oh
         dBi/HnAG6DPDxGzOAIxiwpXsBpqp922PpzTJsFYPgqiOWgJ1d6FYTZ3uGQTnUKajsqav
         daLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=o82nbH8071ZDGLm0iYK2gdlkX600tsvrzfNh6VLN4Fo=;
        fh=1SHnpPhcXsxujA0ifPb99FHOMNPNwzlrum7KxLMq/L4=;
        b=M6stnUzfFeXgrGbOvjkVBU6jWxZWRfTjWzKLZ/JODodeJfnlvbTDfZoNX5OVoomXqp
         TJZzTH2OlRtNKTtTfDVi+185xydyCuQ7MC/R0O2ujt4KhoLKPzPaLc3gVaKHzpMWrHoI
         IswA0G6FNtABVp6soVEaJQv+y+tqTvulXBXww5yPmFQeL/XTMAl/K/e2HRkXQ+yXU0K7
         HJryjbR+3fU+uQK3cg1aaSPXP7xnyG0Pf435oSZ6FXeBMxKnNI+Vyb3wIuTUVz2G+Azm
         5G+htqTzM8tt2OgNZq2dWyevF7LJIX4FbBKPqlif6FNIPziXSwRmTpmGbRz1FWmBBeny
         iWPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781633400; x=1782238200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o82nbH8071ZDGLm0iYK2gdlkX600tsvrzfNh6VLN4Fo=;
        b=JXYp3gXJ7pMeF9WaAOYYO6gSbS5mjDcaZxz/wPa+8kEWDLwRfwwM6/7YMe2P9Bahyn
         QWCBOe0P47hudynegfdEKLzfJzJ50p5G9IZzB/TTy8x9k1JR1j7Z6u/j+ICZSpnlxamK
         KwEMdQVsm6CrQVJ9s6SsKMxpPqN8ci892isftjagSgFrlTT+bZ3nzDqyC3alo0ibbE7N
         5Jp5Rzf/kg2KLIWQnSE/R36/vK1J1yPYiSZXIno0NkMP96yH2uT6W0kq5HyLw1RAOs1+
         qwKMzNSkS6pv0v8wqU5fidqR5I1KRaGca9PsyMp/PMygj2YDYxrvI6xwT9ugbtMif/+t
         gbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781633400; x=1782238200;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o82nbH8071ZDGLm0iYK2gdlkX600tsvrzfNh6VLN4Fo=;
        b=q4GT350c/zL1oLGk1aegR53DAzfd/tJEyM05I/zXcFKpO+P4VtVBsA/IYsYs6kG0mT
         tP6faHjEat1eK/+ajwwY9ycLkCjjZCpwkikk6cXz6RZRWXIgQSpPoVlGDFYitJIscy5I
         gYmtSuunlgWMbipvi0hGz+99GFEjVMNA8tGobncBzH+G0q7UndlMNM3tdW2vO2l2da/E
         Y8uJndpNZxtKH0ryXNHJuvWNZKOXQGZcDJhcSMCW75m8N2GrtSkXcXlfCX/5jERYoo+e
         huvr2Ulq2bXp7yQmPRA7ptftjmePN+mEw1Oatxk/gnTCqJZo9YvYaXoOhgzfXAlBgJK3
         yxiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LFr1NBKGYES/UvfwBkHyvphSkjvlZvPVO5piXO7e5myEZMFXe9QGHe+m0OLn92ASA68ounHmquCQJSonq@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwyJF7yfJCq6nfhDGL2fjC8BB6CoIX4tNHhKua9lalWyrLXcn
	uQMVR19l2RfDImvkmcu63owCT5hkwQQYwVCT9IACyw0z+ZZBgvjMIfWCwmDiLeZEtSLI7UflWBw
	RyIBtBvsyQc/bew9cNFLZTFxYINzqrA7wr0bMTEGJ
X-Gm-Gg: Acq92OEpggTClWNFjolj+HyUcmL2mtV5iRsh7AYDrCbLKbJYxxSFGkoBHLEMFPSye8H
	WD8Ywch7tCnoxpGmyC+i5XPN3bW4WxQ6ft8uvCnIU574p4kfTWHynUEbBX9/pQRFszdZlFhFvet
	rWVJ/1MXH9t+O0KL0ElwUqnmzutBDNwrVqsr/jjaXNCAbBdhkxlEz7eV3/x++ra2dnaS5jw6wgH
	M+Bg+0qmWXpclfLHqi/y1Kmk/voX+P/VmyJr8+NhCxnyk+KSg9fHham/kr8iFdAedN1Mth6YUuq
	b6P0fDDIsRu+Ti4MvpKWv0ZuaZck5rrL/EKBOUlggYhWBr6SklMtODz5FOiTvKx3c9Pp/2exdu8
	rKLWK
X-Received: by 2002:a05:7022:622:b0:137:9399:fc59 with SMTP id
 a92af1059eb24-1398f69626amr23221c88.21.1781633399141; Tue, 16 Jun 2026
 11:09:59 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 11:09:58 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 11:09:58 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <1e77f24d-315a-4f68-a109-2f4520343c0c@kernel.org>
References: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>
 <ai_XK__RTXMCEcCG@raptor> <ai_aczmeH2IA6JaB@raptor> <ajA4z_Wkb93cTW4m@google.com>
 <1e77f24d-315a-4f68-a109-2f4520343c0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jun 2026 11:09:58 -0700
X-Gm-Features: AVVi8Cfci2aZVOJMaXs8XbxR0646nJUtiwZFbcmm9wi2jMlpzFimiOSyoy_glyY
Message-ID: <CAEvNRgFQLEsKanKrj=ePHoShiY2cgQgxtGs_2CJcZHP=JOjidg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] KVM: guest_memfd: folio migration for
 non-confidential VMs
To: "David Hildenbrand (Arm)" <david@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Shivank Garg <shivankg@amd.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Fuad Tabba <tabba@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Nikita Kalyazin <nikita.kalyazin@linux.dev>, 
	Patrick Roy <patrick.roy@linux.dev>, Pratik Sampat <prsampat@amd.com>, 
	Ashish Kalra <Ashish.Kalra@amd.com>, linux-fsdevel@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 6/15/26 19:39, Sean Christopherson wrote:
>> On Mon, Jun 15, 2026, Alexandru Elisei wrote:
>>> Hi,
>>>
>>> On Mon, Jun 15, 2026 at 11:43:14AM +0100, Alexandru Elisei wrote:
>>>> Hi,
>>>>
>>>>
>>>> I always thought that one of the nice things about using guest_memfd as a
>>>> memory backend, as opposed to host userspace mappings, is that the host
>>>> cannot unmap VM memory because of KSM, automatic NUMA balancing, hugepage
>>>> collapse, compaction, etc, acting on the host userspace mapping of the
>>>> VM memory, and outside of the VMM's or KVM's control.
>>
>> +1000.  It's not just "nice to have", it's a core design principle of guest_memfd.
>
> Right, and I raised in the guest_memfd call also the rough idea of Alexandru's
> use case of having non-movable guest_memfd pages such that we can support use
> cases where we can hopefully guarantee that a stage-2 mapping will not just
> randomly go away.
>
>>
>>>> I think it would be useful to preserve this behaviour, even in the absence
>>>> of confidential VMs (i.e, guest_memfd file descriptor created with
>>>> GUEST_MEMFD_FLAG_MMAP).
>>>
>>> Just to be clear, I was thinking that it might be useful for both
>>> behaviours to exist (migratable and non-migratable) for non-confidential
>>> VMs, and allow KVM or userspace to decide which they prefer for a
>>> guest_memfd.

More concretely, are y'all pointing towards a
GUEST_MEMFD_FLAG_MIGRATABLE, which will set .migrate =
kvm_gmem_migrate_folio, and for now, error out for CoCo VMs?

>>
>> For the purposes of this discussion, we should separate the physical act of
>> migrating pages from the features that trigger migration.  As I said in last week's
>> guest-memfd call, I am a-ok with supporting page migration as a mechanism, but I
>> am dead set against supporting NUMA balancing, KSM, LRU-based swap/reclaim, and
>> anything else that goes against the goal of guest-first memory.
>
> Right. Page migration for supporting ZONE_MOVABLE/CMA, compaction, memory
> offlining, virtio-mem and possibly some collapse mechanism if we were to support
> THP of some sorts in guest_memfd would are all reasonable.
>

Background question: how would virtio-mem use migration in the host/guest_memfd?

> As soon as we mix in access/lru semantics, we're going into the wrong direction.
>
> Fortunately KSM is anon-only and not even worth a rant here :)
>
>
>
> --
> Cheers,
>
> David
