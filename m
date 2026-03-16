Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9D3DB64B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690980; cv=pass; b=RCbAGd1B37miwWDKxvr3W1y4V+/qTCInPDm3uw+JWiOCE7s11C+uFWHHx57W8j37MwyQEZBalmUb+B0Vil3JTVLswjOnJS1cXg+D/h563CPw53uMIC806ZDX4ZjdHoSJusifcSFKYllkZGVkR4sGaDEAkt2tPqeY3+5g4f0fke8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690980; c=relaxed/simple;
	bh=Be2mQAK9+wsi0Bste2OJ8qOHy3MriLYDq6+Ew3qALCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ec6Hei257AtF3Z53qgeXUJ6qadNqa8ll9TSl8fxpoFOoUK6vMqNiqHaI6mPJR7AXvyLYOdP+F5BfnkHmsnagirBErBqScmJ/YVSauEqI1X+6EuCt48DzoMw3tP6td22DS1cdaFf26E6uy1BZmSiS9Hh1J9G86hzBzO4sKxuA1ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9jDa3p0; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9jDa3p0"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439c56e822eso5214161f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 12:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773690978; cv=none;
        d=google.com; s=arc-20240605;
        b=FzyllNUSZsCtcUL+BTpRylX531minsigyxVRD5SdL0wlR1ETZypaXqoxbeuccxXWkG
         bNnyipKhy/SZ2h2iVB8YnQURjNMTMcbxYZLkfJCKBo3/B4OSOwbhHmAcn72kwclTlxOo
         aUmR3xN/1IFA1PqTn7FtSys6hTfViZz8lu5P7jAO9sSGmaDYiz8QIWCOfX7uDpX5hpAw
         zoefFmrJssvG1Bf3HEbgC73sRm5ZZUIv+qqzixZALtKgOpfqYqF6W7a2zyPCPlP+XP28
         s3GBIv5zvtOkSfgYsdKp+hPcqTz6aYmMGQw84OfN30vMMcMrz6Y/1WcDkKiQMv9uhJ7E
         zFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9KYIlXS7zuGp0pq6ZtWM+y6OQf1EsZuDREsECH9Kvws=;
        fh=l7eN5hphNMU4H+9gp/Fop18IU3a0YWjcs61VETDGwtg=;
        b=kC39UeqljAM4gfVUcGMU54Rz1KuHSmYCzeWj5umKvO+q6uszD87O+BAPbH6y3UfQTM
         Un6E/SmgaDlV0w5udgYBq1TLcGRT/uZdDkH30qrIjBmxumgipHebRCsI1kP3D7SwAhBb
         Xrfa62Twy6wm3Gd/7ZPIZh7m0ObzPYpilhLZS76ZiHyJmZFu3t51UdB6C3g8XQHEhMhv
         +vYX/fCOVg4cjY5WcynxTUOm4NF6LE28Z+REOMXQLjdRxaPMEUOQGp2SrhBVBWHVWy1q
         H0iq1k8YX7QqjiVmmAe4Z4YEK24rj2U7Zss5B0DnB6PclNbzD4DiNSaMafkTaZ0c9a8v
         jVjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773690978; x=1774295778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KYIlXS7zuGp0pq6ZtWM+y6OQf1EsZuDREsECH9Kvws=;
        b=Z9jDa3p0qlb3bQXZ3dSkicayYiRDBn9L/IXbRJyF2qw7bvpf3rr37lLw54E/zNAZIa
         zXcRFfOe0fE3yQSjlw5cdCUiBZU/hhdbOjF0ss8pGfdBL9U9xyIsP7VexMV+hjKltnSE
         vljADJkKOp2P5m1Jna0TnyuvBMgP+F4mbSyyYLEgIm1d+rHVA0Keonb1r0suMm/YRBtJ
         N0dttJVXwhVEM45Px+EJI6QQBzEPkujiH/SKPHjbsmezqUD4HSW39IizODd6erGwt0A/
         AeoJSoplt2h+YkP8snP0Ww34vP6T2+TAra2ggg0220Hic3UoriBcvuZ5v5JS/jT9r9q3
         T9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690978; x=1774295778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9KYIlXS7zuGp0pq6ZtWM+y6OQf1EsZuDREsECH9Kvws=;
        b=e17KErfRje1oR/aUfklGSYnKue1MEa9dghY54bQC3OSZy1P6DK0+sPex8NsO0mvw4Q
         sFWgp36Ql3pY9RwkfUJ0gUiwKo79SE5o5jvy6EOjNlBQAZbxwBRwf/M1qhltnOymfH0E
         h1q8tV4rCnTwYhHbQHmui1te2x1GBePl2Megh+KcJNmt4uSOxFYJgDR2J00zSOwcab6T
         qiimyNT9ACYj6SV2tmZhP89SdFpyoHM9/1Y0dxL43n/CfKQsyZoN5fuQ911gm76gIQfY
         KV3d0IiNxm9tO4HLg7wwLrX2spqon/k+JFFD75g4H84jT7NY9sVNntdVgLK1BAJHAeeM
         SWTg==
X-Gm-Message-State: AOJu0YzjjnA3+dolujWnHnilC8kqis/Lj/GxK4lPhBz0a/AWJMaOrn3I
	9x/WAQbKhjBjPUkuqh8gfCEo5hAEh3dX7qhblOCQXCCdPac2pcJGWmWeIPoRl++tRNOAVpb0FY6
	kSS6GFREdOF9DjlfbjuoINf+Sa+Y+KZw=
X-Gm-Gg: ATEYQzxaf1OqFG8xVxwS1VeJsKTNPcyQ1mpcHwBO0e/PJhrPiRbaUudjEJ4nc95qkBb
	rT5ohy0Lpu9RGxJ8VMcoZapWRvnIgFjONMpq/wTWqIfVgxUk7LNqXGe2HSwKR1VNJhjiSFd9Csh
	REuGJ+sQP71HwlR4EDDQS3z/v5fNQgkU+gNw/QBhrCvTS5Ngj66rBnm6HElZqK+KGkg5OuD4yIb
	Wv1z/w+EgXFBVS0yNzLjw6BRytnAxouw6L0OsLQNlkgn2ej+ajCv86Rtf9RGuZKOqmLsFECaGa0
	0eZyDw==
X-Received: by 2002:a5d:5d08:0:b0:43b:4aba:8f38 with SMTP id
 ffacd0b85a97d-43b4aba9108mr614750f8f.47.1773690977596; Mon, 16 Mar 2026
 12:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316165320.3245526-1-mszeredi@redhat.com> <20260316165320.3245526-5-mszeredi@redhat.com>
In-Reply-To: <20260316165320.3245526-5-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Mar 2026 12:56:06 -0700
X-Gm-Features: AaiRm5252IcB9uCCrCiGplIPdyW-xtOy3-6vCSrziqn2bctLS1YoRHlNu3MkBe0
Message-ID: <CAJnrk1b8A0eK51QfNLdSDac6mQXHqs4FUJv7okqFHyTeehBBeA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] fuse: don't require /dev/fuse fd to be kept open
 during mount
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:53=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> With the new mount API the sequence of syscalls would be:
>
>         fs_fd =3D fsopen("fuse", 0);
>         snprintf(opt, sizeof(opt), "%i", devfd);
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "fd", opt, 0);
>         /* ... */
>         fsconfig(fs_fd, FSCONFIG_CMD_CREATE, 0, 0, 0);
>
> Current mount code just stores the value of devfd in the fs_context and
> uses it in during FSCONFIG_CMD_CREATE, which is inelegant.
>
> Instead grab a reference to the underlying fuse_dev, and use that during
> the filesystem creation.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/fuse_i.h |  4 +---
>  fs/fuse/inode.c  | 54 +++++++++++++++++++++++++++---------------------
>  2 files changed, 31 insertions(+), 27 deletions(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 230201dc3f90..4a591a436324 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -606,13 +606,11 @@ static inline bool fuse_is_inode_dax_mode(enum fuse=
_dax_mode mode)
>  }
>
>  struct fuse_fs_context {
> -       int fd;
> -       struct file *file;
> +       struct fuse_dev *fud;
>         unsigned int rootmode;
>         kuid_t user_id;
>         kgid_t group_id;
>         bool is_bdev:1;
> -       bool fd_present:1;
>         bool rootmode_present:1;
>         bool user_id_present:1;
>         bool group_id_present:1;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 0e848e3a13c2..314fb37f272f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -800,6 +800,26 @@ static const struct fs_parameter_spec fuse_fs_parame=
ters[] =3D {
>         {}
>  };
>
> +static int fuse_opt_fd(struct fs_context *fsc, int fd)
> +{
> +       struct file *file __free(fput) =3D fget(fd);
> +       struct fuse_fs_context *ctx =3D fsc->fs_private;
> +

I think we first need a "if (!file)" check here before dereferencing?
As I understand it, userspace can pass in any fd value.

Thanks,
Joanne
