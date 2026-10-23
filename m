Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776785;
	b=g8C2ElPdML26OY2VD+eJvwL7FBjnjq1XqC85NNQyuQisv58thk9cgkaeBgy9V+qFber9
	 aI+jLbyoOur0Tpiq/ShWmxi6drIi3rFtevhi2nT17z8/KBxNJG6X/90+v3PVV5axN1J5Q
	 ahio15pzeUVTukWeSDr8hH58JxSRLilAnJgulhvMAwpI0T2DxiyI8gYhDdMXNWGFWKO9g
	 DKO3yw151J39ylQ5sUJair8sCuhraPnXeQ2LC4yR8CouNAU42I0ThlCPuUSB59G8jf5uB
	 ZkA0+P5Sy+XNEDl8PPO5tE03IwJIIDKSbVptPN+giznuIMnuwagcy5UjLYfjG5/0EzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cfFhlHkKVrFXSmeZYo5gvz1zhcXjNjoycIItBCRV3ic=;
	b=sNZd0j2IbyjXv//WnwzKyRjMVuujMaXvmVMDwXv5U/Yo4MIEZGR3gQ+/KCvLtMp2C5C5
	 ytuHJmPv6q+m6A7miMXzE3nXZ+QO+RaDzjtCMYhBuPYyM+JUe/Dp02XB841bQL3peRaWp
	 SGacAdzEg7S7cZAMZwNvvEmo6VaA4IJ21FtRDv2ntQNc7dIhtCdzW2Oks5IOsy+4YJmeE
	 yEfQYJvFZeZ1eMufi0VcSHWake48NOBghVjb2VOAJjA2AKRIF0wmAhdoiopkynpR2NVXq
	 +RkPLuHpiB6kuTm3RauUXLrXk/1TIQhQTdP7axPkb/YdREQO/e91BNY28WMOuGO7Dcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=VaUL86p9;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B3606A31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 17:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 487B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=VaUL86p9
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b10ac6ab7bso12082327b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792776784; x=1793381584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cfFhlHkKVrFXSmeZYo5gvz1zhcXjNjoycIItBCRV3ic=;
        b=VaUL86p9W8Ij7nYadvTnLVjLIfxoXTnftnSupztuaXFLBc6HgsqzB7Ud1HU3voaBfV
         c2YTLHbQHqYx2hkLgch0SU0B3lGA/gmKMIPW9VNGGCnHWFAFLxwS484qhvmHUJtoyB4U
         q2lFWjW0nq/2sf7CYgxkhuwWcEw43EF6y5znee2MjSsvzNxINWEHc4ljORwkMTsmrvPo
         s7HWAHb3HuI+5eNje7YQ2qyjU6I+vqiE7JDVD+pvU5F1MR6onOkC7wwX8GdI8yxmvUws
         5v5BFI9yt3KWaO3GLPyjmFYDh/LS0ZqzRrqFuwIXL7nRitjGWEBgml9N7vpBtdPzWlzv
         teXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792776784; x=1793381584;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cfFhlHkKVrFXSmeZYo5gvz1zhcXjNjoycIItBCRV3ic=;
        b=WbFKVehS7FoBXpIck/bpKUeumDfyA6HQEUteemLnFHx+x31bsBepCXKiPO3ipfLH2O
         oM/Dexl8rfwAYNS4i4/zJsFbbdXtI/S/EHcAIxCwGJuNoPoXyELU0a9OeASNnXj+4iP9
         kd4dhGhGZPdok/UOWX7yeaLt5Zl8sTevr0geQLwjiidFjiW0UZyz60a6fqZh1gssIa0e
         anMW0M/B3GLNUK6+4PELTt8u+jGuzKetoTF3OQCnhFZJSbrJkVOWvMfCk5vduT+38eN5
         LSpa734zFNV7cfDAfk90JduMoN1WzEDVu9cXsZFe4QY3cOmvn8zQOG5SL0lcVUhWkTNV
         OtQg==
X-Forwarded-Encrypted: i=1; AKwUvBydcmL4mc9X4m4VyEjqrRRKnQHXGtWt2KxZw4T0++h1D+hxipNUs880aadGiHpkRm2mJiNVbs31+5VWUy8r@vger.kernel.org
X-Gm-Message-State: AFq9FYKsWZW8Yzq4Q4wcS97yF8O4HKUWYlX9gt5Cp/TZEvM8cxiYsfoD
	rpPDfY8uTj5Wxvh+Y7DrhRweZFwDzBFBoSvvUqPvBmj8LaVxgkG1TFHILhUJRZc+WQ==
X-Gm-Gg: AYBFou3Nldc91wlKf2XWOylp87sBeOMHUDEOsXA6LOs7qNjW4NKcsPMhy4+3ptYvQ3O
	0tz4/FpFoT4/0lsBDekupuUyO4PqXudhlXIb9z6mkdw4Ug1xYy1yfoicgn33empi9Zs0b3fBXEw
	9cNGGBJ/E6mvMe0dwizbhY7meHQ7fZ0RuFDYw4vVg6AExO6v8qAAQzfAFefB6FkFv+rqhxEyhQi
	MaDQTxmTl2z3xr3VBOBscEh2BcQbANbOVzouZpAK600/XQ3B7EeHnzUTjkY4na1pm/5TvffkYPj
	njq4lN/s4RqCMsBLjLtvoh/XvlEGgd/aJ8wZS/rv7IPY+kEOsMbvcpen7vERp6cFcOULKPUDLKG
	jGOOWluOB4ytUO58k4XZcjW9iQTIgo6SApf+rp0srqZnQco7WcE6WlEpGn+98OGCFAJsh+A5QbB
	XrO5i7xUg61+rtQw2PGL9QfAXO4yE5KUDyqIQH5JAhNOS982w9k2SGaill22KFOWyOxDrUpcjT9
	8kFpX1vkW39Uhp+PdGIywX/PBgLs12XO62sez1vTC5x4/4dv/Rz06oNxgpODZ/vXvlhyv1Lb3YQ
	0QZeIRk5loCej1jV4VjM1rQ=
X-Received: by 2002:a05:690c:4f81:10b0:8ac:d999:c588 with SMTP id 00721157ae682-8b157ebbd25mr16750107b3.69.1792776783879;
        Fri, 23 Oct 2026 10:33:03 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b163d54053sm2770937b3.20.2026.10.23.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:33:03 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
Date: Fri, 23 Oct 2026 13:32:59 -0400
Message-ID: <20261023173259.3275078-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cd6cc32dd2aae90b88b4c3d19e1fb35a5be6f4ac.camel@dubeyko.com>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu> <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com> <20261021153141.311425-1-hengyul@cs.unc.edu> <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com> <20261022120658.1328124-1-hengyul@cs.unc.edu> <cd6cc32dd2aae90b88b4c3d19e1fb35a5be6f4ac.camel@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

On Thu, 2026-10-22 at 15:40 -0700, Viacheslav Dubeyko wrote:
> (1) Check that deleted CNID is the previous to the next CNID. If it is
> not, then do nothing.
> (2) Oppositely, we need to execute standard b-tree search in the loop
> by decrementing the CNID.

I tried this loop in KVM on a804c5742bff. It fixes the first two cases
from my last mail, but not the third one. There a (CNID 17) has no
thread, so the search for 17 fails, next_id goes back to 17, and the
next file c gets CNID 17 too. a and c then share one inode, and
fsck.hfs -fn reports nothing:

    echo AAA > a; rm b; echo CCC > c

                          unpatched or loop    patch
    CNIDs of a and c      17, 17               17, 18
    cat a, cat c          CCC, CCC             AAA, CCC

A search by CNID only finds threads, so it can show that a CNID is in
use, but not that it is free. A file without a thread has its CNID
only in its file record, which is keyed by parent and name. That is
why the patch walks the leaf records when cnid - 1 is not found. Its
first check, do nothing unless the deleted CNID is next_id - 1, is
your step (1).

> Potentially, we can consider to have a small bitmap of allocated CNID
> in every b-tree's node. Any other optimization ideas?

A bitmap in the nodes would change the on-disk format.

Deleting 8000 files (KASAN kernel):

                                   unpatched   loop     patch
    newest first                   13.1 s      0.40 s   0.44 s
    odd ones, then even ones
    newest first                   3.6 s       0.26 s   9.3 s

The patch is slow in the second case, because cnid - 1 is free on
every delete there and each delete walks the catalog. One idea:
next_id only has to stay above all CNIDs in use, and fsck.hfs accepts
drNxtCNID up to 4096 above the largest CNID. So a delete could leave
next_id alone when cnid - 1 is not found, and the walk could run once
at unmount.

Would you prefer that, or the walk on delete as in the patch?

Thanks,
Hengyu
