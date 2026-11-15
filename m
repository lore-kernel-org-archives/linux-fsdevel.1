Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716871;
	b=xB6Zw8Jq00NHHD8ITre3PohT9EaK0KuT4l6Lo2QfInstQr21h0FLaxC0ozoDEk+gSUtg
	 YiWuUEVWSGjLwRZVxxBmBDd/vq7MiYFDlr95BCSiW0w95a6oNssaO+inraXf/QDj7Mfdm
	 j/8fF1xiiaMx+17mRMcdF57HjvX3V2uWSS/oaPRH0pXDwjUeiKW5C+5+IECQ/Uqua6svN
	 TrFXm9Vgyt5Smu1raZfoUapi9s7cLf7M1n5diMTWEaqOt6SKmTOpXbXkIX9tTiAtrYzXk
	 L14bChtmuZ2peeWtpShqH4BcgKOXfLQ/PYlUNthNeN3ZYraj0pr8/pOvO1ObixfT0IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
	b=ls2urC0zK6GqmUnGAFlBsxUn2FdD39F5IQV7HvQPUfEBEzA1eHgJJBXQJM2zUqPwYxuO
	 A6XwvFbR/htf+iZ4n7a6SehcfdSqfepoQfkiUG0UwzGDXsJB2N+v3C+R06sy1nWoGYCxK
	 zjDutlhA0hBRl07u9x9v7Z+SOUkZPL7zQWoPKCGy7tVjTFoZy1sJzsGiSadIwyCJ1EUuj
	 coFI10UCQZfPCa2FGdsoRNw3rA6Spw2GD6ouozq+HiCXO0No7vXMwDm3BYwtQsgAp4OBS
	 uO4Jz4Rrzav5gj9rOf2+7SwGFw7OVsyGB20PtHsl0lGm1uo/N+/1yahu5o77Tyw7VWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrlCOM14;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48789606A32C
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 04:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48789606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrlCOM14
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so3364578c88.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 20:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794716870; x=1795321670; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=rrlCOM14U7o+M+TZUPRKm/0B5X33KfTWozBYOwW7G1T5mICv5uiTGRDZ8N/E/WkgPs
         Slt3WdfVhPxLW/Dfkkb7/xGjvq8CIoTpYPwhvbdCG6Yvw1BgA2N1EVe8mN0kEHKHXyef
         8tQmPjoZ87TzHMHH5DbiUhIVkAX/fu7oGi34+wAuHuH/TAi5YSfzTR1lg6qENJCTh/vf
         bWlX56f+34OBBzkIC9iYt9wgmDyB8Cq+Fbc85HrZX5UgurcmY8nnkwgd3auzrRPvQadc
         V+9t/jgoM5TmoX0d5ZETJARldRFhGcH0iXCu8yq6U0k0i+/1+kk//+frMRudpsSSkh05
         Ua9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794716870; x=1795321670;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=yLDkB74m9HNQIO4v/X0+1HcxNF7hZI196Uk/cfbycQ8pWS7fbCdkkSzkiM54JoooGl
         ZG+kfK7Y/5fzICnu2FytY1PqMVxULNwOWBqgiEGnd1qHOrbD2zMTSme49TIHu64jwxvF
         6sCfnVCQ/mIlSAhxq/iagBje4EOHfSr5DUiPLQv1EPzgYd7CMzT0eaEkdGZgU3PkqchT
         T8BzO/gjIf9pbvF/iZhl8d96fmdZmv8eCHrChclnCXeSQOVAvS7mn6vxbSLyrYDC5id4
         RTRyy+bfYLZbbtxl6FgeWcPLBtXVq+oN0mVAS/gzmzRxERtdIJnUJA8fy8fWIW5a9J/2
         Tq7w==
X-Forwarded-Encrypted: i=1; AL+hErEPDCfar8IoKEKHY6eu3uTb5mcAhGXTssYdS3cuR0mCFosCaAp6nBFn5tJO9Tr54dU4hhWd0lXI5qVOCktC@vger.kernel.org
X-Gm-Message-State: APuU4Z/d5cj1fcyrgwNueP7CJPbKKrRCy9nJllMpque/TB16+cHx6vM0
	kx7RaPewljo6sK1nQdIcWgR14XmneHlmmxKlApRhz9VL3nxdL+JBiUxm
X-Gm-Gg: AYBFou0RDcIe/barCsN3Kj/p2YfcY7DH0f6BjRjOQZ0odDfX5pCtZK9JLkeTxK54ftS
	5v1KvM149ErQq8cYPyGB8uJGIZ6/pJRv2snsY8TV0edhulxPhCwZRw3PMqwoPGulcZl3utQClfD
	xDxdTiS23ILSYNX5uMXT26PEzT8LqrLJGDYynsvhhngURIevJRCiCDwnkMJsLfXjpFDpf4m5CBP
	DaRK6OEz0+MGjQn9XmDQy1sLZ9TvX/b00JlsBDZYJ2V8Hm9/a1NUrn6I7DafFtvD/o/VegoA1MZ
	K31GRa0fg0EBMhkC3OJ4+j/RTOpFPvuToSjCC/OE49R97xB0DEHtBC5X9vfkgn1ciCntGO0Tu9O
	/jkhMa8T/Hcl/riylYo24lFZFoUlR1ply1z/jYhsgaQ+VzN5Kz7L8fhGMJ2ZbMu15ujtVQ+jhfj
	zoWj4GK2R76sZYY6UTvUnCFsCu5rEHSOCk69b0tAj5ZlqJjOjb+za24w48ftkgan+nF6+G/KtA8
	VAQb8/1luhuVEwzNzwBHfNb9HAV1YCbj1k3T6044KTWo3HnheW6ZOYxI2O0bGXPi9cFhKutLphw
	rr5tVy3+NXekLyTJPy/RWSjQInU=
X-Received: by 2002:a05:7300:ff46:b0:37b:c89d:1d56 with SMTP id 5a478bee46e88-37bc89d354bmr1627673eec.12.1794716870280;
        Sat, 14 Nov 2026 20:27:50 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm20640706eec.6.2026.11.14.20.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 20:27:49 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
 <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying
 Huang <ying.huang@linux.alibaba.com>, Alistair Popple
 <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico
 Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin
 <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro
 Falcato <pfalcato@suse.de>, Kairui Song <kasong@tencent.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, SJ Park
 <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes
 <rientjes@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, John
 Johansen <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?=
 <omosnacek@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
In-Reply-To: <au-DXpEi4wHwsz0r@gremlin>
Date: Sun, 15 Nov 2026 09:50:28 +0530
Message-ID: <7bie914j.ritesh.list@gmail.com>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org> <au3r0-geuwtRYPiC@gremlin> <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org> <au-DXpEi4wHwsz0r@gremlin>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Lorenzo Stoakes (ARM)" <ljs@kernel.org> writes:


>> > It's not really all over the place, it's converting vm_flags_t to
>> > vma_flags_t across madvise.c, which involves changing a few function
>> > signatures, whose callers must be updated.
>>
>> Ah, yeah. What on earth does arch/powerpc/kvm/book3s_hv_uvmem.c do with madvise :(
>
> Yeah it's quite worrying that... :)
>

Thanks David & Lorenzo, for pointing this out. I have changed this to
use ksm_disable() instead [1], which then also removes vm_flags_t usage
from there.

Please take a look at it whenever you can. Since it also removes the
EXPORT of ksm_madvise(), I think we will anyways need an Acked-by there.
(note that: looking at those changes, it seems like it should go via
powerpc tree)

[1]: https://lore.kernel.org/linuxppc-dev/0500fbfbb98776091c89584155368610095b4dd5.1794537345.git.ritesh.list@gmail.com/

-ritesh
