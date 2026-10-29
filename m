Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793244460;
	b=qPEiSsKxdeXeox6iDVCmtX/niHJCFYNpgAb6VIViyaAxKwhx2bf5QRD+Vbu/NoEEIK7k
	 T685UdZbBkwrHvCC6KFxqXCmV60DPNnJ+198qAXF/ywuvg+H4J3LK2IJu8Q3N/kL9vqew
	 LQgft9oVRdM5RuTaCfFe9MJgcuN9oTZQipKPZiK5S8wz31IRGaK1lSwSmf1t4JB5NiyC8
	 HIpFibgBPOrr5Mr8lbJBetcdckryGJHM3cKB59mSpbzgJEUZK5aJXw3mCWaNgV2xDthB0
	 aSHfNSc8t2k9oLpjv/o6j49YosfJ+jzrFtBKZFYkRzz8mKK7K1EJ3czPsvnNih34nUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244460;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=0DjsjpXU96UP9kDusHJgpmPdkD8cLQUHrfge/mnRBFE=;
	b=CiG2LZ9oQ1koti6Gp2ODcOKjNvS1hTSfE5Mda9/+faxaEp6KLUWOG9Wh94cy4Q+yGnzw
	 UHkc095kRe79h3JYLxiG0G6URzeNwh0b5QL33kQrFYEL/Jgh4KvL8bKtdINI4RlHoZ/9H
	 Wr3EEaQrPDU6Gx7tlagsAjrwgw7eD0b1Vt3NviW0qymViwleZ88B88Rr3tCAcfXikmXUE
	 I0S7FUFXFFP18yBkRzCbCDeeyKlg2jF2y15eFU0JKQdU+E8hyDBPvS8aO863s+tDRxlwT
	 BiFpLChKuoQNczok3f5PXGjANhq5sEjrew3lgULhEPhFshR4YpMG9Woyl0ekpttVtCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gmSxhDFw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA13606A322
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA13606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gmSxhDFw
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T38MZl3364751
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 20:27:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=0DjsjpXU96U
	P9kDusHJgpmPdkD8cLQUHrfge/mnRBFE=; b=gmSxhDFwHSvjFfh3grfM61H6IYl
	/+Ns3n/+6o8BFC6o2G1GzFtYw23HbA6l+EpCNLDr9pmO56yEGTYp4GlY41fcvnw7
	7YsDSeNG9PCpxfL+ESWZH+QcFRfov2pfCG/7pfgsl5czd7OimMkuoAB89+OmRojZ
	QnqBaA+FJLPouNC1oia7VKdQTjybhJSi/uQhjlKFhWfWgaib8ZjHUSwVuuaekVvH
	uWvSyIwGRewKHoBV2Qf1OVEsWPYIZIGtAlh19aeEBvx/2OW2Zj0oED8wpjHcOy+7
	5RP+qo19y9FifMRm/HXv0PZKOl2tiFANfsyzsKf9cJCSs6wEl4A/8CRpkrQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hk0j8knxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 20:27:38 -0700 (PDT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a3451ea93so298873eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 20:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793244457; cv=none;
        d=google.com; s=arc-20260327;
        b=Ux4RyZVJnBXL4kFd1VMnjFOyHs2VBA0O/1MVnbUmucGaprWzg9IKmOAnw1Kv1rAphF
         ten1+0NI5PcrqB1QkJq1ZWFeHJpVOCPl1KOj2WTM5Fzq9te6PSw7ze2UxWUUkwptvBne
         ARE5h49v48Uj7pXfsaHDolmQz0zQv9HVYO0ZTD/y2YONQFnacgRA7T5/Bnq0J7XGCfPs
         3rAgDSsDO7CB4nHyoW4/DBpzxGdEPlyNamLegQygcxJKxKkNWpMQyrlImzFzGcN2t04Z
         vjAQg+4/5xjWedIuX8qAd6MA91tq8r29A+q8Vk2EI+zOJkCJDXPJZUD6QllW7zVIx5ij
         XKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=0DjsjpXU96UP9kDusHJgpmPdkD8cLQUHrfge/mnRBFE=;
        fh=y8n76oZZf3nJ/jCaWF9573qpLZk5uTqL5Ti8heC8ih8=;
        b=lNDzEyg+zcAZNb3e6hW5fsTKZWUQ+hQyraBlpxrdA+5R74s5EyAseOPXdMIqlqt/n+
         nW75OuWAxuOtYcQVkOOXmpwnLBmC5gwxDIq8CLCgBGevkQpPJAlvZ27LgWPWGVeapu/1
         RaLwlLM9TvtDgF7RqNleUROBVmR7SEDigYQqy4KKVR6OPrHDTczrQTMCgAqxdrGkfqah
         HSEq84fsmg5rponEfvqQM8fQb2Dv1Fk3Jn5yLBJlQ8l09mj0nUh9cU4dj8ZuCuYPsKGE
         M6hbXjwc2mFtPuXDbKkagJtVHaRiWZfw7+duNfLkwLyWNTe8rAHdr+1yhmbl5TSxvEFd
         CcXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793244457; x=1793849257;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0DjsjpXU96UP9kDusHJgpmPdkD8cLQUHrfge/mnRBFE=;
        b=Yu2CtCX5/I5YVdi0xDrNpwbIeHMZTD40/Gx85cwPieF6zHGq5mkv8Y7j8fWp5wJeyY
         na5ECOJnKUdqsXbZkAFUapz3CPdwTgICjSkkp0nF2pZdIh/+ah0/tMUiEt6g+JUxwD6H
         fsk0NKaSS9SPiDRerWHdM0Sdg55sHjnQNImEAYQVwvDYNoKKM/GMc44xT+UiRxeiXhop
         f/f7xvbKGJfIWpTZMtV56P45VURNrSDVlkqOdp9yk0czxdBeVRreNuyEA/VEgUPT7CfM
         VvDpOK8bml3+oVjlv6u0wOaZ/PxC7xI0bL3tIe9QY+FLGv/1nqec4npJy+5sf27+RSbu
         9Thg==
X-Forwarded-Encrypted: i=1; AKwUvBwhjvnOvyz6M6sCzT0qGUUFd1p0vzqjUkhcZU0aqTKqbuHNqYFYQxb75jCwS71Gm1MbUPxmrTjHv3kqGIiA@vger.kernel.org
X-Gm-Message-State: AFq9FYJcyOUrMzCLk8Y45wZ6CNo6sHHnYc0tXEqOj4zpvXebc5NrKcsQ
	O1crfkRX3OsF8gBaCcsixH8stERZsgmi6FZYvoHsVMso3hW1+5R3cy6EXuV9AtTnQ0gHqSCxaEo
	1zdvKbfscyKjmLQaxm9EooEhM2VdxeIgo3oTN8ILCzrpGBy44q8eThJWDCQrNVAyTx1E7LnJP0L
	QyLLJ8SjuqLa9nXFsA+RfzOTGQ5zEg5BoAYpMzDfua
X-Gm-Gg: AYBFou2JmEnISMrDG2GVlqoq7PZtishR1ZiOummTYZGUOo/QaDQqEknALyohx298oaw
	nB2B0Mz2CKbOfeR0euAFLrf5nWow4IQ7Qp+Ruf6Qnf8GMSJQqhjajYyTJGrMM0MmuDFkpMPRkHS
	Bt6K0n4nwEYWnVkhn9EKAqCM8oFiHdBcB7skcetulwl0wMX07CgqlbwNQ=
X-Received: by 2002:a05:701b:4203:10b0:143:3c9f:10a6 with SMTP id a92af1059eb24-1a6c9af1e26mr5876945c88.4.1793244457298;
        Wed, 28 Oct 2026 20:27:37 -0700 (PDT)
X-Received: by 2002:a05:701b:4203:10b0:143:3c9f:10a6 with SMTP id
 a92af1059eb24-1a6c9af1e26mr5876935c88.4.1793244456694; Wed, 28 Oct 2026
 20:27:36 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026201101.3915217-1-leonming@meta.com> <87se1qhvz7.fsf@igalia.com>
In-Reply-To: <87se1qhvz7.fsf@igalia.com>
From: Leon Ming <leonming@meta.com>
Date: Wed, 28 Oct 2026 20:27:25 -0700
X-Gm-Features: AclHuK-KIZ_96J7m8EUFsiyjK1WGV9FQATfT66Y3r8LemRe76Zf6qMGUQGEgGVU
Message-ID: <CALJ5FXmnb0QU3KtmE-0ieX1ApTSMG0gZ+Hg-TSeG1G2mLd1itg@mail.gmail.com>
Subject: Re: [PATCH] fuse: set dentry epoch before making the dentry visible
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joanne Koong <joannelkoong@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=YbkodARf c=1 sm=1 tr=0 ts=6ae2bd2a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=V2sgnzSHAAAA:8 a=lT1PLGjMyznquQLvSy4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-GUID: PIHWFIBvrx-slZMttxPOKZDdCtK1nAUE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAxMSBTYWx0ZWRfX6/qKcaj66/ps
 jD7bUNf7KDbQUpSOqiFzlyrpMKD2h8fJJy3w5J7lALXKpiqYzvMuAjMdgs+1RMWx0I+325Ui8cn
 Ufad5J7irtgKxVknvoOZA7TFZrMhLIHInVI3lNlC4U9u/Pc4KoTXg87tn5v5Yd3RTWKy6Zl9IgL
 BE8aps6AhJMpa7ApjBHFUh0blsXy9fMJJFttv2A9P+sKcSjotMSWg72HElav1cCFghEOPwp47uw
 gB9Szb7xlgyCLtNkU0TQ6Wur+rFiDE5g5RQJQRI+cXgUM71KOLFXfGNDPcC2a2+zbzlOjdi/4/O
 5iJYJRTBCL883N314ulr6/XAxQqvvGar5SJg3ecL4N7aoOy8oXjsy3lz4UDB1CT5fy/Xdns+3jV
 8gn8KesuyNs7uUaQpgVWF6qtqRxi5mLEwhvemIGS1Bnn2OeauJGdH+ZdJmImJ5oyQUlwGVi+5xm
 cKRlO4C74mBo7fZUxbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAxMSBTYWx0ZWRfX1aJKAVGfMyV7
 3cSfDmuhBbOOZ3JWFKko8kPrAn7VrMO9wsXAehNkX86QsPtdwTTOeFikvjsoyofmX7j7bVQSg+W
 CkT6XZ46x+z34X1HEsqaxgJ43tURHoI=
X-Proofpoint-ORIG-GUID: PIHWFIBvrx-slZMttxPOKZDdCtK1nAUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01

On Wed, Oct 28, 2026 at 5:03 AM Luis Henriques <luis@igalia.com> wrote:
>
> On Mon, Oct 26 2026, Leon Ming wrote:
>
> I believe this is very unlikely to cause problems, but we're slightly
> changing the behaviour here.  Before we were setting the epoch only in one
> of the dentries.  With this patch we're *always* setting the epoch in the
> dentry being looked up, *and* possibly in an alias returned by
> d_splice_alias().
>
> Can you see any possible issues with this change?

I don't think so. When d_splice_alias() returns an alias, the dentry
being looked up is never made visible: it stays unhashed and the caller
drops it (__lookup_slow() and fuse_direntplus_link() both
d_lookup_done() + dput() it), so nothing revalidates it. The extra store
goes into a dentry that's about to be freed, with the same epoch the
alias gets. The alias itself is still updated after d_splice_alias(),
as before.

In create_new_entry() and fuse_create_open() the earlier store only
happens after the server has replied and fuse_iget() succeeded, so the
error paths don't change.

> Personal preference: I'd move the other fuse_dentry_set_epoch() into the
> other branch ("if (!d_in_lookup(dentry) ... " ).

Done in v2. One catch: the alias returned by d_splice_alias() in the
other branch also needs the epoch, so v2 sets it there after the
IS_ERR() check, as fuse_lookup() does. I added a test for that case; it
fails without the alias update and passes with v2.

Thanks,
Leon
