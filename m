Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793270951;
	b=atd70uucTkSykIxvz5z8VolirxUuQL/lShnmIN+7d5ZLE0PU43T21jwTjVRF0L6mVdR9
	 dmwZwhcxazabNgj6W9ojbqWienZ3F0hAjtqXx0KuIvlQVNlCcyuUsGZ+vBBWXpD/tOlx/
	 Cj1+/nvkqdpT9Ytce4rTi3XbEjado8YlSSUF3zRaGq6TzVqxVtMuYp3owlDrLEf0lWpD6
	 J1m/Cesdkn/psOcUZ3/TliWxVLIzVX8qD9pFy0eTPBuljGNT12+0Q1qE6ZNgGKicJ0Wtv
	 vj3kU+zibpjbwJ3H3bA1wkJoWCzgnb3NSrVoOuEiZIgY/uZgGRwLw4LcJJHjA3OW+zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=zbmLqSufNSTz7oFSlgljM7qVDxU566qZ/gshg+M3kMg=;
	b=Mw8MsZCgoYiSD9bTFpDV/Ub1JJ6E451GjXZhh8CXtISCsb1pp+0UEI+FNnxeN9E6Wo/l
	 fWdoVydLTPcCbvhSz+5maaZU9KvDYAJVbTO84aBPQyZz56Lep0x2Py7kMoSb3y2IhPOEb
	 g48oO/vGFTOGFOGzdbYwAWOWOVuXrJXiWkX+AvsKex8om85PSqjSOJto4X+TP4Qe+glpJ
	 pK3AIx/e1XTfbhDOnL6rOaFWvYawXMDqfnstNdK7zz/LRo9WYpAyxmzeDTAFPj9FItlvu
	 FXlai+oGLZm3lpDy9FDpfXlDu9R4tczFkQTrkhcklSdsGLuEfalUKAHr+leDR4fqU3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BKH3pDyD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28288606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28288606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BKH3pDyD
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso2977204a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793270949; cv=none;
        d=google.com; s=arc-20260327;
        b=iFtaRbdxigw0HQwgg3qJ+0rRPh44QefpJKPrjzLYyazuUl+6w1jo5iUOpoPAl1E+QU
         RBlAiIHHhAplI5YDD2sDSFScTPLILMr3WsClD+Mp9M0AyNWbSUxc6bFm33SDp9alfTHG
         DmQqREb+D4RmjjyQZsmPqLVpllGEZhvmuZ0ZzE6mOFrC9pVWBG/TUNSu6hK7of0BbM9m
         VsDTvWi292Bnb+3vTh0C8GgUidR8z0sGp4uqxPk8L2Bxm5x86cnR4MwufgRvrTJB5TK3
         +jTJoL+oItutF803ja3V/0VEeBNryLAkYTrptRPLQtVI5jP3lQ568HGveqM9fW6ApEVX
         yK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zbmLqSufNSTz7oFSlgljM7qVDxU566qZ/gshg+M3kMg=;
        fh=51HLPyYCpW7VyUR9dcYz5vRBh2AGClQjqWCjCZ8c8m4=;
        b=H4Vp820r+0JIGq76vow1mu7en6I8NS7D8ljiYwB6PaBzpuFIXc7jd1h4HeY+NxVLlg
         M/Oezwvi6h2BJXBN7XCfK7SM3Y+otcKZikNDSkNMS5l0iyaxxHO6jA8/NGGP0E6+dkf2
         40FHDoxg6AaQr63L5z87u6HyR7Bk9xwILvUu3UP27a7fNvXvXpbZyPmwdKt8Q8GU7XuL
         MOQftrQS+1Fw7f5OpOj7wz8xllVBzgjNerLJKCw86eVCpgXjV9nTQ8gWHPizDCjTzWF8
         xYZTeFHtqr+ml1E1UJrLAqCbhy/7CGAj8FXTqHBpDwXQ9TkxCkfaZo2byX/ylKKnKdAR
         j4ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270949; x=1793875749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zbmLqSufNSTz7oFSlgljM7qVDxU566qZ/gshg+M3kMg=;
        b=BKH3pDyD8Peoi6VBs/TTujk77dzyHxS3Dh1lNPIzpHjV27LsMgouencJlZ+5iLCn82
         jFejVtTnjK8TchiFPnwi+6upbTkIgLtdeAN8ULmxNXbo1eY/VuHrfWvxTEgOxwmKDGii
         TydXYPE8ZH9Z/D5BooPg5oFWTlTlSsvKKCRDsMfV6/619zhBDXUDuJFymXX6FXkBP9yJ
         Gd78HpNM21fCDq1+m8c4NY1IK77qDtwfh72JcRuZlgwOt0VRFV3gQnic++QjxYp2Pf6x
         KAKEZ/2yG0O+rf3mODFP+WZkIeUQIefmrXwGNlACGd0fkSmU2TdvddgLjRIPJjxeOQDf
         nwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270949; x=1793875749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zbmLqSufNSTz7oFSlgljM7qVDxU566qZ/gshg+M3kMg=;
        b=VeskA0DmcWHluuhKEdveuPy/Wh4DUO7Q7JQ9OKI4eQRfxRqii0lhwUJxWkArlCgjoJ
         EbrOsPrdbTdSKwsCOpG7885Ti2Mreb3i/Gr375pGiUrF2kdVCCUqIJbhafmwEYviVE6C
         MY4jKlD22iyHivT+QO+aAYn3qreGgCE6FOwlIZh34rWWB5vyVogpfrIKBkxjiYTCvqeU
         oMPbXX+1SC5ZQICOSVqfjrNHKsjHMUjSDUdV8BkDnwRq6dJOtHxfd1RMqt8IHB1NXJfY
         wG+XGmUwVbwYc3JyYRJUrGz47FdzbDA/EqxKhfsTr5PvbOLNgUuHTanSyc3XdRxa9eyj
         2f3w==
X-Gm-Message-State: AFq9FYK3xjRAxgEYCONRZV3syjHz7kuoHgr4XtZDYEhSEqJuPmg562mO
	yEpqiQ/TFVQGOH/fi3cgK+vL3BAfjeVb/1Im+DfJBUEQHonhQR8IsRbXs305FiNuYB1rY4LBarz
	mf5f3Z0FgXXl7cRkWlUCYtgn/pVNB2rd/qQhw
X-Gm-Gg: AYBFou3R1aZzeADFdbGJ8Avcd3iSmeo/Nfyg/Ca5qoWRXbbznXa2U8blWRm7tphMszr
	C83TWgk1dnLSwpF/xJEPctv9BBCyr/HCf6CKLM99gE4kqvrz1NadpeMgu1NadkwV8KH8RuDUlsQ
	6XNs7DfOSNOndoKCfX9uWoMw+Lb/eW9e9c+cDwnS6uY9EsfUr84dVK0c1dkRWGMoTaFycOCcTS8
	47NdTyycAhKPA1gLkLCqLNIRR/XttaXCxYCjpPjYtyh1gYjYz/mSkSu1qBeg7T+nCjEHh81br4O
	zM3NJbnFR3tXBYXBOskXjSDNlEzrlT1AMib/7dhIP6JPiMuYJ1bWtrXcnkkcI/ujyf81lhKP/Rw
	/gjsi+9+hvJ3spmYgFgKuMNYKbjChQ73+gAcvrAp6Lm5hnQPp0jC/jDbdM8g/dQrd+nSy1qIZ2f
	bZezHV/H11W/WqHw8=
X-Received: by 2002:a17:906:eec8:b0:c46:723d:600 with SMTP id
 a640c23a62f3a-c49bdfcdd65mr457878766b.41.1793270949125; Thu, 29 Oct 2026
 03:49:09 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029103913.2785828-1-amir73il@gmail.com>
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 11:48:56 +0100
X-Gm-Features: AclHuK8r166-yi4e5XCpY2GFgL3aAI1tQ9q3Pix1qn3NFJ5gY5SUbe4Q2pHlDUw
Message-ID: <CAOQ4uxjDJPo5ectRdOh9T3oRCL=JP+n8KvvS4O4CssSMH8uCWw@mail.gmail.com>
Subject: Re: [PATCH 00/16] Overlayfs fixes from Chris Mason (batch 1)
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	overlayfs <linux-unionfs@vger.kernel.org>, Chris Mason <mason@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:39=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> Hi folks,
>
> The following batch of patches is part of a collection of overlayfs bugs
> reported by Chris Mason.
>
> These bugs were found by Chris' AI code scanner (kres), but underwent
> extensive manual auditing and filtering by both Chris and Josef.

Sorry guys, I meant to CC you on this cover letter but missed.

Also apologies to the fuse list for spamming them with these overlayfs
patches by mistake.

Amir.

>
> I thank them both for handing me a reasonably sized pile of patches,
> most of them important, correct and ready to merge.
>
> The patches selected in this batch were either simple enough to merge
> without questions or important enough for me to invest the extra time.
>
> Patches that I changed include a note [amir: ...] with my changes above
> my signature.
>
> Notable changes from Chris' version:
> - Include "fortify ovl_copy_xattr()" and "assertions in dir cache"
>   patches already posted publicly for similar reported issues
> - Use LOOKUP_EXCL in "do not copy up a dentry that was removed"
> - Add vfs helper try_take_dentry_name_snapshot() instead of open
>   coding it in overlayfs code
> - Fix for empty security.capability from Josef adjusted and rebased
>   onto "fortify ovl_copy_xattr()" refactoring
>
> This pile applies cleanly and was tested on top of 7.3 and on top of
> master of the moment.
>
> Backports down to 6.1.y are either trivial or already prepared in
> my local tree. I will make those available to the stable maintainers
> after upstream merge.
>
> PR will follow soon.
>
> Thanks,
> Amir.
>
> Amir Goldstein (4):
>   ovl: fortify ovl_copy_xattr() against underlying layer modifications
>   ovl: add assertions in dir cache code
>   vfs: add try_take_dentry_name_snapshot()
>   ovl: skip copy up of empty security.capability
>
> Chris Mason (12):
>   ovl: do not copy up an xattr value that was never read
>   ovl: set OVL_WHITEOUTS before publishing the upper dir
>   ovl: check that the parents of volatile/dirty are dirs
>   ovl: take a snapshot of the name for copy up
>   ovl: do not take a name snapshot in RCU walk
>   ovl: use the pinned upper dir in ovl_fix_origin()
>   ovl: hold a reference on the parent in readdir
>   ovl: do not copy up a dentry that was removed
>   ovl: fix a torn path in ovl_get_redirect()
>   ovl: read the nlink xattr of every indexed non-dir
>   ovl: always encode the origin fh when index is enabled
>   ovl: set the revalidate flags after d_instantiate()
>
>  fs/dcache.c              |  29 +++++++++--
>  fs/overlayfs/copy_up.c   | 110 ++++++++++++++++++++++++---------------
>  fs/overlayfs/dir.c       |  22 +++++++-
>  fs/overlayfs/inode.c     |  14 +++--
>  fs/overlayfs/namei.c     |   8 +--
>  fs/overlayfs/overlayfs.h |   8 ++-
>  fs/overlayfs/readdir.c   |  61 ++++++++++++++++++----
>  fs/overlayfs/super.c     |  21 ++++++--
>  include/linux/dcache.h   |   1 +
>  9 files changed, 203 insertions(+), 71 deletions(-)
>
> --
> 2.55.0
>
