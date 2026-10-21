Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596719;
	b=HItCxU1tedlbHGVMhSsTuTLgr27Vl0Nd05lJQ2hk73C88GesyrgkB4muqMOTAC8oT301
	 dIclKOnv7YRJYRNwddKry5pCATZahJE8JYiVLiW3bGBzh2iweLW9KhBfoZqYKShiWvj0P
	 TRR1CW7hmzAgUV7uGl/9rILU5C16oPWsR3va5lLbHJLr8TduU0jxd+hZH08RGSp4uk4Fi
	 o1mtKwdm6/YQiInNnXKcUCbeI4MFboBMpLwaNDAJFMz1LZzaDkvZ9m1YD/OalbZwBnRvs
	 +VJ8TiKkh4u/m+2GKqYF4ut07WVEz3O4SnIND95SxTeV6cwWxIgHyr6p5dkKbrDKbrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U60Jt81TuPOI1PeKasuheW/i54eVEfO8tEZphtbeDLA=;
	b=KuFNCOC7KImfO097qUb2TZB+KFfPxVJo+ej0T8ayvmZbGmaMizwlNivHuIh1rs+YzVuH
	 kK3uZOG6gxUHX2NONqaQt2NM7d3E655gtP3bPHrI+XpoK8vOiCGsVrzOM7FYXCUfjKLeR
	 VOlvojo9DPOJhLasjbeDtJbyHxhvK20qpMQmkMsw/ekePnURkpTUTULFgwXo9xEebSIcL
	 rCOA0wCkHiLRLAzjghC2BGflk2FPClHYI9lXsryYHWTOmSTiI/BEu9keALZozb9h7ChPe
	 dcwGk6OONqmuZp/QE350PVhkh1/4oVnqf78yK+M4HiVrn3CrObj7miuD9tCocNmnmFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=GTCTxvWW;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43C606A319
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 15:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A43C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=GTCTxvWW
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8aea7b7ca0cso7830047b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792596718; x=1793201518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U60Jt81TuPOI1PeKasuheW/i54eVEfO8tEZphtbeDLA=;
        b=GTCTxvWWN6taIv1gq+jX+lLGYuJaKpoETO63WPtwNtbu2bYi++1sBLFKypCjniXV20
         fdbTQP6tghJg8x7Xw/VynSmxQarpEr8On4ba8zvFZVAmLjqRgAsjehjgunr5S/guZBm4
         N4QPCWQDWWwf2vNncf+jsqJPTkgDj31iYSWzYKk8twHGE2fpRQVtvUB5iZ7vznvRzEWu
         XtKbhM21uT/+w4qNsXIq5WGI1k9Q2AYWX03tuTOFf2euJ/lv5AV+Iy1nmvkqQNVO+8kp
         LH1nilrY77Fmz3H4kGoQB+L/IgfqeRe0g/knvHxgmBpWBngXIpuaUqqHwqxXIAF933SV
         RNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596718; x=1793201518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U60Jt81TuPOI1PeKasuheW/i54eVEfO8tEZphtbeDLA=;
        b=n87Jx2fL82JBD9t0zFQ7iJ60TeE1zDYsbD8xJ2CUbk2s5zHgFaSDsvyvp3VeBBnqN8
         swNRe2p+Hfkmpv0hfhWaxskxz2SGLvMHBqXTtItOToqHNCXP0JLFuJgHrYARW/e91eI8
         MgS6dXjrTa9rDsaYkEdnfpHSUCv9GNJ8YrmNBW5Aze5eYiAplf6v2Pb6kWTefkeNrmzy
         Ro3au+8GrRUlUqXqJ1groRFXCixZ+izvmDHTbLdzNzZ/hYwQ0lXL43OL3fI9gGIyOcUY
         XQi/XLbJZjWCiRCbPxrMg5G0eRUvUiQBAdOnq5ZFRYL6Fq7K/UPzBaNmeagJHGo8HcjS
         CqNw==
X-Forwarded-Encrypted: i=1; AKwUvBxZ/u111p9nM/JgRAxg8CMVX9ITUDZVchRN6BUn5IBzboyL5XEkOLTCR7ZCoQyt7jgqRBzQHXNuLWAw9fU8@vger.kernel.org
X-Gm-Message-State: AFq9FYIZlZ0LkB8cZUWo9A+nDstpAGgHIygH7YIBasCz9WqmhMBbTjVQ
	X8cLdYGOQ1ckDsvIm8nMRyxBMhEYIrEGZdpdYyJY9ZmPn3d/D51lr5wFj1tSfdx3p9xoIkXy2TS
	4yZ6/6A==
X-Gm-Gg: AYBFou38CKcVZSTv36cN4ZcVs4c2Lop/its1NUXHFkLpyZeuCMFSKFEu12JYQB/g9P+
	UZUmLY+QcjlIlbLYGJbPj+QIaBnUnOlM6xi1GvPtWHOAhxOFQTYTZwlTu2aYa6SV8HrcFyCjjqG
	w6ossWj8Px0YcKdDQuFO50wiceIyUeT0CWHxuCSQzIGDbseZXmN+W+qSR6ggDDmWNfWx2BT1ePp
	hx80PTYbfMAQ5ba3iyh8Qws49wkQjiwGevDvn6yCxG+W9DyRXkWHzNyKCYrIaqDmsJJ4JW2ay+m
	GuSPgpa3Hnjk42Qn/RusuRikl2w7+E9lCxgk4ntA6BKZ1Fx/MDdwV1AT6/5KZkHuGp9NYF7oSUu
	NL6ZVa0iJIuIlHwC+C8znKowYVyTVwsWRfbLnSTaAhBRddZ6xU/cgnoc3f8DdxV0wWlloEHI2kM
	4uco3OyE+BI8kD5uxsrbaccJui1LWlCx0lRxb9P81ogJ/6CVNQ6Vof4tEmo62jfH/BHngVFg43g
	Bv1ECO0jzPY4TLfdFNqL8uLom7VbmGbPtFeUoX9xXrlBZpZIuARuhDrMb36+AmLeSGa9UIjlM/f
	UA==
X-Received: by 2002:a05:690c:4804:b0:8b0:c673:993c with SMTP id 00721157ae682-8b133fa1b99mr11730777b3.21.1792596716533;
        Wed, 21 Oct 2026 08:31:56 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300f3cfesm13054287b3.27.2026.10.21.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:31:55 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
Date: Wed, 21 Oct 2026 11:31:41 -0400
Message-ID: <20261021153141.311425-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com>
References: <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

On Mon, Oct 19, 2026 at 04:29:16PM -0700, Viacheslav Dubeyko wrote:
> Frankly speaking, I don't see how your modification can fix anything.
> From my point of view, the current logic is correct. Probably, the
> call of this method is not in the proper place.

Sorry, my description was not clear enough. Here is the reproducer
with the actual CNIDs, on a freshly formatted volume:

    operation    allocated CNID    next_id afterwards
    mkdir z            16                 17
    create a           17                 18
    create b           18                 19

rm b calls hfs_correct_next_unused_CNID() with cnid 18 and next_id 19,
after b's file and thread records have been removed. The catalog leaf
records are then, in key order:

    key                type           CNID
    (1, "untitled")    dir              2
    (2, "")            dir thread
    (2, "a")           file            17
    (2, "z")           dir             16
    (16, "")           dir thread
    (17, "")           file thread

The backward scan skips the two thread records at the end and stops at
z, so it changes next_id from 19 to 17, although a still uses 17. The
next create gets CNID 17, hfs_cat_create() finds a's thread record and
returns -EEXIST. The correct value is 18.

So the call site is not the problem: the records are already gone when
the correction runs, and calling it earlier or later would not change
the result, because z still sorts last. The problem is that file and
directory records are ordered by (parent ID, name), not by their own
CNID, so the last one need not hold the largest remaining CNID. The
patch keeps the call where it is, so the drNxtCNID correction that
generic/736 needs stays, and only makes the scan take the maximum over
all of them.

The unpatched run in my previous mail matches this: the first create
of c failed, and the retry got CNID 18, so the failed attempt had been
given 17.

> I don't quite follow why do we need to change this check? If cnid + 1
> is smaller than the maximum one, then cnid + 1 is in use yet. We
> don't need to execute any additional logic. What am I missing here?

Nothing; both checks return early in that case. != additionally
returns early when cnid + 1 > next_id, where the cmpxchg in
hfs_set_next_unused_CNID() cannot succeed anyway. It is not needed for
the fix (in the example both checks go on to the correction), and I
can drop it in v2.

> Why do we need to check something for previous one? If the bigger
> cnid is in use, then we don't need to do anything here.

The lookup only runs when cnid + 1 == next_id, i.e. the deleted CNID
was the largest one allocated, so no bigger CNID is in use. If
cnid - 1 still exists, it is the largest remaining CNID, and next_id
can be set to cnid without walking the catalog: in the example,
deleting 18 finds 17 and sets next_id to 18. Because the fallback now
walks the whole catalog instead of stopping at the first record, this
keeps the common case cheap. Only if the lookup returns -ENOENT does
the patch scan all records, which also covers files without the
optional thread record.

Thanks,
Hengyu
