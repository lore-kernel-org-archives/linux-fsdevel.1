Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794490257;
	b=R2P4mHJnH9N/Az+49LDzRdCaaLk5ZGh4Nl9ttu2Nax8EzCaHSgwc9fi+w4Kg28CrNkoq
	 9TQr38PkdeyTpGPgpxbH5O4sgyJUdV8oYIIB36Q6QhMx/lXgh/PyPS66hRiNDK69Kn7CK
	 Vg9lm5sfH/RP4mV5Y5G7JTeZrg0OfmH7+zoINVaTPrNpycEec++bKRLJkpSWWyXJMDy8s
	 YllMFPH3lRy3kF+Ib8pbPS7NFs9Iu/ILAxgmla5Aw+0Gg34wJHhbGAzghezYH3Q0wcapE
	 3suAubv/caxE73G36V6Dxcd/b1nFoh7LmMDymnExqT/YgoryAJfRCFZH48KaHpNHqJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S1xZYGW3sp4V9GD5hAamXepdrQgJ2mYyugoBZizhATM=;
	b=bqZs6xfJ4rkiUqQ/E3aBTNc36SKUsy+/KihPPUhE6y5zGj6gaSQeqN5YdlX7zoDoKbyY
	 QppQXFTp9NhmCbZzgcGyzn6qHsB3J5yzAYSP5/9QkZ/H8rtb//60IQuWBEdiG9jJ5hzAp
	 WSEpSI19dQg8n0KTuUX+Wx8pwgGM7vAYXSk6I3f7MG5k7YcpvlUMInejqeMnOUHn3cBAM
	 g9DmJt9nhZawbVXjX0OtVm4eEj8Uz7gVH8JzS2+kEYycuMyMu4TU3F/2YlIcePdIACwof
	 AuU+ObX2hnS8Eqt46rFMIoXPS05pAxZciW15UrpMhq55XFhU4insatn/5r2uNo/jtlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OAMZCKUT;
	arc=fail smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B592606A330
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 13:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B592606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OAMZCKUT
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490d59c3edaso671951f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 05:30:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490256; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHYXGkMmzk6QJQuYSvtiEC0sghJ9hDS+5uksSTYZwt0tl4TUBetEohzd6E0qxjxDgv
         QRrgFfINkWqlVcUndwlgeXs1zWiQlPlYRnHJLERyVhUvYuapouMwo4Q2jjwpL8sRXvg5
         gdpiRNjfAiZZY6wfyc8xRRqYDKUid/rI5edlYn5lYn/YMA+Cgpm1OqFAwalvNVJySP0x
         z8xp8ixtLACnGOjLeVCKnjNRYfRoGTlpQomh5WqVdtYO/dkNa9p7OEKtIjGSFBmrteFI
         QJnhJSek9wW5fFN0Q0xfxujYY+e6gJXTdru2lm6rHCAfID2U/VHyMFvIIe9RctVz9c1n
         5XhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S1xZYGW3sp4V9GD5hAamXepdrQgJ2mYyugoBZizhATM=;
        fh=mYmtTR0/KR2fWGJ4bdvsWVWWa47cP/UnlUiL+leEd40=;
        b=I/KUySltROd3mB6xrZ085k87UqD4JzVGnCfuloC51DsZdgyHhOo5ieT925MxvFMXdl
         h2Qu6bFzSTtAoWgjiEGZ92tXafpLwstGy5XkVUmUolSUpajwd9w7XqslzObGLn5Jnc4o
         g/fAYxciOlIitfax7JQM8mZqLFMKanV5JpDMf1csafIK3w2KAsC1LYyX1592CjwQTmpW
         NcqOY0P4BKqb2nY9K5MVd16jF8o8cKHjfCATpuYcmLWJkwvdx/nZ9GwXaU0v7ad/ogCu
         +V7LVb1T14SzZFR1ZzXfrvXEzAXa3ziUkkDH7cLi3uPz4bJdF9tjIyUuS+2S2pAIgBfH
         XlrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794490256; x=1795095056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1xZYGW3sp4V9GD5hAamXepdrQgJ2mYyugoBZizhATM=;
        b=OAMZCKUTw3l6QKgGiSX8VX6jr2xJ0IvEcRr9aN8o+RSKzS0Ud1802z5BmqWJ9NxpS9
         o3yLiXe7EpfLOU8AotMwhaxYDX4IYn1kaXcRWUjxRNpbsVVTbOoX65nZtlh4BRg7T78D
         MTxgNivkTdUXHnu2V/QGcXltawmwZRgBJaZ0sSaelhIj00Pme/vMlmyVyUawmp6C3OCW
         1iC+F2PRLrkgfuby5NfOjvtseFVMYZdoGPviqrzEx0yJTu2zE9Qu083p+IxoE7l30IGw
         8rESjm9DJhyoCPUVWYMRKsEyZzYzcOZZZkiu1d81jda1IdrKguAiClSkm1H9k/aPdZ6l
         hBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490256; x=1795095056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1xZYGW3sp4V9GD5hAamXepdrQgJ2mYyugoBZizhATM=;
        b=ICBgzUFH2apBmXt0SifLvt8mIc3PZQQ5Q8VsiwJDZMAscX0L3r4rOjhzs7XCh/O0no
         i7fT0miVRS5MOZj1gY34x9uI7ZGj6JwUtAW0N9/6OTDqgami4s3eNdfa3ETkWAL9H7Aq
         ViauSaLaSNIjWQX5rzZtiCHSzLF3LsaWdPiV5Vdwgi/TO3nTJp5+jMj0hzfQP/EwNEMC
         KLeRrxkDsapd1ftMFdN36QxyvmDDFxKJ3ZFcaXHN2NpgaUuzephyW/3NekggY/WdOBM+
         SFCHaqxEIohFgmRKGXs0z24WCBR03hfXsyDIw1+CXSRaWx90w656ud1pjAyTdwyrBOCT
         +8Ig==
X-Forwarded-Encrypted: i=1; AL+hErHZieueaO+3RRp4y0p9gvxFA4aMOIBH6034YEWQPltkgrlPg+lDGCkw+73rHzOKarky4YKgjObTt/TbYnDK@vger.kernel.org
X-Gm-Message-State: APuU4Z9BjkPX75BgEOWju9ct90kFzyx81UOOswTzCKapOVWFKBAMg9bt
	BClWbM/Pg4bX02HRckORGo+fE2/ys9HEyiJYstoyUO24qlj1m7oxa7fl2LLpPv5UAPiPdqbxuOv
	tdCpRSjWZ4Fdjnf8EscD36tAmyLNiBcA=
X-Gm-Gg: AYBFou3ShsHyb6Dzza+Tse/Q56blEo1m4mT5pW3b2ykfhJqUQUFKF4QFwtkpO1BNKUW
	DO+Mgn+s2CIpHOHcmtjtHvjY0nXnvvomBAbUWP3YKrGqUoQUVLO/1RMgtcCHXXLimurMfROqHpZ
	kJXlMyINqvYNP/Lh4Nzcuzno/YyoxMvOBbN83VVvaezkAtbfyDJPUpNbRdxru6l7ALkSbKS2xlC
	FBtVJO+J/1Zzf5bG2P2OLVkCOrLnCIrmcVoWsVrwarpW5X+GxVFuJhXeAfFwxQtwcfm8ZkMcJsj
	EgaM5wfzhXjyFllXPXXqLlY9bnWLZLPRLV5evmFPw6D0AlojGzcJrPmGqVnYVbHdeCoIFH1Qe9R
	uP+94hlzH4DgBaNZI8zrBdQ3NEQ7PGrhElcPon7Thqdhaj+f6Y0b3TuRhvJ6GUFOT47/pQjuYpt
	eZkzxmW+Oom1/FuNtNHejVqami2rk+8cWe0W8dJIs8ySRrsQUSwnleBvYJ0l0IdQPacSTJyoLa3
	Q==
X-Received: by 2002:adf:e00e:0:20b0:491:632f:2c8f with SMTP id
 ffacd0b85a97d-49afe168872mr4263229f8f.2.1794490255492; Thu, 12 Nov 2026
 05:30:55 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org> <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Nov 2026 06:30:43 -0700
X-Gm-Features: AclHuK_EMQbfmXamV3TaIqS6catb5--28CKUD5GkvfpyfyoaKenoCKPieGjScZg
Message-ID: <CAKEwX=MDNW=tj5cfSrAN=VG-NEd2cax6f7QHcPfGDc1vTix+TQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] mm: cachestat: count each page only once
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, 
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:14=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> It turns out that filemap_cachestat() can unwittingly return incorrect
> page counts, if large folios are present.
>
> This can occur due to underflow - nr_cache is nearly 2^64 on a 64-bit
> kernel if the input range starts more than 64 pages into a folio that is
> split during the call.
>
> It can also occur due to pages after a large folio being skipped if the
> range starts in its second or later XArray slot and the call reschedules =
at
> that folio.
>
> Finally it can be caused by pages being counted twice due to folios in th=
e
> range being split or collapsed during the call.
>
> filemap_cachestat() walks the page cache under the RCU read lock only,
> and for each entry it counts the pages that lie in the range. It does
> not track how far it has counted, so the counts are only right if the
> walk returns each index once.
>
> But a large folio can be split during the walk, or small folios can be
> collapsed into a large one, and the next entries then cover indices that
> were already counted.
>
> Resolve the issue by tracking the current index as one past the last inde=
x
> in the folio, and explicitly using xas_set() to set the current position =
in
> the XArray.
>
> Additionally, add a check for folio_last_index reaching or exceeding
> last_index and break out of the loop if so.
>
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: updated to use curr_index, fixed comments, updated commit message =
]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks, Chris and Lorenzo, for taking a look at this!

Acked-by: Nhat Pham <nphamcs@gmail.com>
