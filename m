Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85765388E64
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581569; cv=pass; b=nv2dMzCq60hGZWdDlp56rpKno48zup70gJkbUAp75qrUYvISGsDp0oFciDdnSoTmj39eriT+HkY9ez3gbt2LkLrwuSreDCyhV7pCHwHzNQqE2P97s8plmrRwsBX1++dwVHgcN04YgcGh0Fy5gfpKUTbKhgSPXJ87WcOtM7zsGKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581569; c=relaxed/simple;
	bh=GcsfMUg3yCMfT0aO2UCldG9cwALVHJ0VJOEmJlH5r50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaY+IcOUZDMQfF2UI/MJUMcT7MIlWyd+ee75GKfuPWBUc8oQ9ygkZ4S5VL0eFu/bhZ+NT8jTFAtTBpedu3rVicatV4XWGtfCymA1Jf9HuNkTAr+IxUZ3mXVdoIPeeywWbWD1Qjtu8cdZwXCQIPDYSPbsugCVYzLmkw4xXE2zeVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Yux7he7u; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Yux7he7u"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176096116fso7792901cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 06:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780581565; cv=none;
        d=google.com; s=arc-20240605;
        b=liXvSJPc5eXL9zwPl7MSGnyMZlYBXYX2N8n+cEuopAqqlft3iGOuQchtBEQ5P3/EXR
         VJfd01WWFXHeQJcaI6XOTp/8itgXO24QNm7tOagm0zj/ghcz1zcd6BkVwGFxwxxkRVMg
         7/Y9AQW1xMEx/4gAdLpsaeuLmwjaPX7a56BCgdVc4NiLsjq8CKmJE7eyzSsxP04MIMA9
         wcomhHR1pgJE7mKodnVKv8x6FKx4LO16gTbtiDnyMeXg0Soungc/R3Scp+NHK/thosJG
         TrHgDl5uh+ujbwE+88YPkaQNNfS9LQGelK3VGTRcG/lU3h/ZlfNiql5YqEtrcTqJlDJI
         l9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iJGxeXrrW2oLpAUFkW48W6w5shufffcNZYyapXzoAqM=;
        fh=8DWHPIM5gs+l+N/EPv4Se42WW+QONjVEVNAyRrlBr0A=;
        b=XAzT5/5xP4Hcv6RG3afvunNjW0tb/VuRTDJjlvQrl5hUz7Pz/+yBl5GNmUy9WrLlhO
         UlhOma2tNWGogC5Ftxh+2VylqbaenvCukFtgy/haUknjfxMf+Bw76G4e+7BnmFcQ4Q4Q
         /4ukenoAGKamxdxgXXeaxD1q3dil/wtvAFcXBrnYVzEbhk7Nc8CO/dT3OjEuRKlz0Gp8
         Khq6dYIzyMJusUVBRR4ufrWU0VSYPHgtE/ValGfVaHOgMBjaN6RmwIceKJz4Vu2S3lZf
         rY0EHWdYbFTmeElnOeV3+8TlGpofdCtiiuWkO0mKPIZJWLBOdI2zfgKX6oBuuJeAc0Vd
         Neag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780581565; x=1781186365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iJGxeXrrW2oLpAUFkW48W6w5shufffcNZYyapXzoAqM=;
        b=Yux7he7uaa5lu/Tbn/OMpBUcyEYpf6mvTfGiqG6q6XUdY2H6K/E6BRgZw7UwOtPav7
         H1KOFMFuvMNyjj0/zMVxUVTto9B/RVUdfg8DAhloNHSB+cACS7R5Z2qYKpGOd8Csijwv
         vH/IwJ70EpYltoa/sMPqv1e9U8QqMT+0BbLHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581565; x=1781186365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJGxeXrrW2oLpAUFkW48W6w5shufffcNZYyapXzoAqM=;
        b=lHO5QsUT5Pt2Bsx4nEQ51Kxqc9Td6P0XvMUvjMA+/8kpyXazxgpxAk/6INersxhXyB
         1qqYnfmSXAK50V8Fi2UZd2SrBkFIYkMBiSiWld3atGKRCgMfnc46LvMe4ipDHk+1CvFM
         WxSUkok8maX7H03rYtoI6fGDsQJoq/p3FMFTJyT8AJ8Ld/MaSQLNXByhSY6uiyhP97kX
         v3rjpcLUsgDA3V7Q+1OTtgotpVQ0lBwDfBAe9Zi0vQohX1ahvqT8wC6ZtqYQUslPBK8a
         O7hwbqBCnAzI5cOQovTfRBttqI/ttmpH6UIqEUiOhyNv/+cp8MCsOq/du8tvx41wGB/9
         yIDA==
X-Forwarded-Encrypted: i=1; AFNElJ81yN0YPJSM/SYYZ9pzFMpwMQRgpw2IJBWzbx1LjmpEXJWuauP4MtzYmi+xt3VzyzCqGYVnbjzj35gWMIzl@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXaVUza5IqjiN8kMKXTfOq/2/xwl5bRSr7tZEzvb7dbVgQPqx
	8v+z2Dp64fo8K9QrwmXmcIXfK+Ay6gbhCBoM3njQXko+rem4BQpx5Da8oT82/XZ8A9jvDDRuBGu
	BXekRsEa6XurJTzkzKmtiUl3YDU41TnTMm2P0vzFvHg==
X-Gm-Gg: Acq92OGQx80ZmQhiDOyAky2kIypjeFrWhbHvSYCxZKq6K23lNTETAeRX/HjNwR0oRKN
	IXCu8smXWtp9+6+hBSdy4/0fu/34K3Q06lUPlhvG2qxBH6qSRQUjZo74A3wLhJjA6aMW1XmFGz3
	SjsLNaz9fVdB8bmJEG9versVN6hCz5jhLwFUy+V+f+S7OejoHLSCe8sV4I/ceaZJQ8mwnmgs2qY
	5B/1lk5qIzEP3LjXoTcAmO1AfBbosFEMJj2kqRrauS1F+QiA2TY70VyM3HGLBDjfHS2x0Vv2e53
	q8VuctUfDCRk4e43toZD47CT3cGIaLmp2sVnr+zQfLC+iUw=
X-Received: by 2002:ac8:7d8f:0:b0:517:29c1:2b5c with SMTP id
 d75a77b69052e-51778781e85mr116546621cf.60.1780581565419; Thu, 04 Jun 2026
 06:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
 <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com>
 <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
 <CAJfpegswAZv8OmDAcK-5u8kssAF1vZKe4gdDB2XPErAnoGFSYg@mail.gmail.com> <178056619459.3392745.3091041855723132411@noble.neil.brown.name>
In-Reply-To: <178056619459.3392745.3091041855723132411@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Jun 2026 15:59:13 +0200
X-Gm-Features: AVHnY4KXWHwA2rDtnMrlahBdYAmljXDTPRnUfVXdC8XkTG3_P3UeGgO6ZIixP0I
Message-ID: <CAJfpeguDUS_3X-AFZD6XCJB1SjVkFGu2aJ+p1BK574Scu-ASdA@mail.gmail.com>
Subject: Re: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry
 after c9ba789dad15
To: NeilBrown <neil@brown.name>
Cc: =?UTF-8?B?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 11:43, NeilBrown <neilb@ownmail.net> wrote:

> My guess is you refer to the need for retry-on-error.
> I need that design so that locking can be pushed closer to the
> filesystem and ultimately, in some cases, removed.

Aha, but this is filesystem code, we don't need or want to move it
closer to the filesystem, it's already there.

> It is a lot like the reason that we often use cmp-xchg loops instead of
> holding a spinlock while performing a simple operation.  The code is
> more complex but it scales better.

Okay, so this is about making VFS more scalable?  Can't we just leave
filesystem code alone in that case?

Thanks,
Miklos





> Thanks for the on going review!
>
> This is my current thought about how to fix this code.
>
> Thanks,
> NeilBrown
>
>
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 70948fe385da..7d744c7b923a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1601,55 +1601,74 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
>         dir = d_find_alias(parent);
>         if (!dir)
>                 goto put_parent;
> -       while (!entry) {
> -               struct dentry *child = try_lookup_noperm(name, dir);
> -               if (!child || IS_ERR(child))
> -                       goto put_parent;
> -               entry = start_removing_dentry(dir, child);
> -               dput(child);
> -               if (IS_ERR(entry))
> -                       goto put_parent;
> +
> +do_lookup:
> +       if (IS_DEADDIR(parent))
> +               goto put_parent;
> +       entry = try_lookup_noperm(name, dir);
> +       if (!entry || IS_ERR(entry))
> +               goto put_parent;
> +       /*
> +        * We need to lock against concurrent create/rename/etc whether
> +        * entry is negative or positive, so use whichever of
> +        * start_creating_dentry() and start_removing_dentry() works.
> +        */
> +       if (d_really_is_negative(entry) &&
> +           !IS_ERR(start_creating_dentry(dir, entry))) {
> +               /* entry is negative, it cannot have been renamed */
> +               fuse_dir_changed(parent);
> +               if (!(flags & FUSE_EXPIRE_ONLY))
> +                       d_invalidate(entry);
> +               fuse_invalidate_entry_cache(entry);
> +               end_creating(entry);
> +               err = 0;
> +       } else if (!IS_ERR(start_removing_dentry(dir, entry))) {
> +               /* entry is positive */
> +
>                 if (!d_same_name(entry, dir, name)) {
>                         end_removing(entry);
> -                       entry = NULL;
> +                       dput(entry);
> +                       goto do_lookup;
>                 }
> -       }
>
> -       fuse_dir_changed(parent);
> -       if (!(flags & FUSE_EXPIRE_ONLY))
> -               d_invalidate(entry);
> -       fuse_invalidate_entry_cache(entry);
> -
> -       if (child_nodeid != 0) {
> -               inode_lock(d_inode(entry));
> -               if (get_node_id(d_inode(entry)) != child_nodeid) {
> -                       err = -ENOENT;
> -                       goto badentry;
> -               }
> -               if (d_mountpoint(entry)) {
> -                       err = -EBUSY;
> -                       goto badentry;
> -               }
> -               if (d_is_dir(entry)) {
> -                       shrink_dcache_parent(entry);
> -                       if (!simple_empty(entry)) {
> -                               err = -ENOTEMPTY;
> +               fuse_dir_changed(parent);
> +               if (!(flags & FUSE_EXPIRE_ONLY))
> +                       d_invalidate(entry);
> +               fuse_invalidate_entry_cache(entry);
> +               err = 0;
> +               if (child_nodeid != 0) {
> +                       inode_lock(d_inode(entry));
> +                       if (get_node_id(d_inode(entry)) != child_nodeid) {
> +                               err = -ENOENT;
>                                 goto badentry;
>                         }
> -                       d_inode(entry)->i_flags |= S_DEAD;
> +                       if (d_mountpoint(entry)) {
> +                               err = -EBUSY;
> +                               goto badentry;
> +                       }
> +                       if (d_is_dir(entry)) {
> +                               shrink_dcache_parent(entry);
> +                               if (!simple_empty(entry)) {
> +                                       err = -ENOTEMPTY;
> +                                       goto badentry;
> +                               }
> +                               d_inode(entry)->i_flags |= S_DEAD;
> +                       }
> +                       dont_mount(entry);
> +                       clear_nlink(d_inode(entry));
> +               badentry:
> +                       inode_unlock(d_inode(entry));
> +                       if (!err)
> +                               d_delete(entry);
>                 }
> -               dont_mount(entry);
> -               clear_nlink(d_inode(entry));
> -               err = 0;
> - badentry:
> -               inode_unlock(d_inode(entry));
> -               if (!err)
> -                       d_delete(entry);
> +
> +               end_removing(entry);
>         } else {
> -               err = 0;
> +               /* must have raced with rename before we got the lock */
> +               dput(entry);
> +               goto do_lookup;
>         }
> -
> -       end_removing(entry);
> +       dput(entry);
>   put_parent:
>         dput(dir);
>         iput(parent);
