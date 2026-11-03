Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717212;
	b=4ycSysHRYT6MBWhov+TmmTfcV0ByiHeD+YlMNS0L6VvBZ0vj43vG1uTegcI0PjXifoQY
	 gaaoOpyfp1MtYWDv5rxGESPoVgfyFJsy+ck8gAaUjqMIXDM2773h1Or2K/5DoI8XJrAy9
	 48mF4wyPg+XuZ9z8vEuiHBd4BPtGbeMjGLct1qaraHqdGCTwunu0OeLg9Vpvij55otNjI
	 6tuk+uYD6kX2bNth5qVHr0YufnWaJn9WdiiDXkjpV650iMxGiyfDTCMsgtR4jtRjSE2K7
	 EUY12ItX0smWiFlk3FY5KCaIRY1WMaGA1KQM2fcqeS8k7HT5ixTw0/cAG5LaSlC7+rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m4ubhwdD7xWNz1fIp4dSNo/j/2+5i9zC1GJT/QlqxwA=;
	b=bVv2l1NS56ymEZe/PCvk9MiVITLixIunyHp39lZM4370U9vvgqHoj4Dn0k44j9SIRSYL
	 kM5cQhh+Qm/ArZzJVkhFK2CNBpHmKvIacMUMJCkYmRjfnM7r0qbnUmkVKMVT5VVXmU/B5
	 FFi22xQpC72SrSsECDmvImmuATblXmUwVHCNg5YxePghakjG5lEG2PTIXMyVJ490WRUBq
	 /yCqwl3lk1i6BbJH5gGlrYnCjhsl0CEzpIGQ2QoP/nuMzsfh2OllyZ3R09sLKq2h2kW26
	 NnuNkcKuwNNs19XI6mx1Hc0LUir0pDKjdKqumEAD/YFW9lllGkilw7dGKIP/xUoja3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbwMCgGj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF6606D805
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 14:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DBF6606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbwMCgGj
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso660079666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 06:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717211; cv=none;
        d=google.com; s=arc-20260327;
        b=IpxZ1n9KuGmS7+RyYkOgmDvaP8N8enBS12KyxsglIl/oSTqv0Yb8uUe8f3TZCcI1jK
         C+P2Y41bQ9Xdh5ZqEr0AJK17ZawPcP2fyDTizvfYCICY5FFG11aQ2CvTgimGK5FuxIVw
         0i/suwEQm1tKrLVWOXyEu7rbWweHtETPnJqNv2q71a1ur91ajGSWRnpDKbqETUPq6peq
         w2yd3/MwazKYrpASyFoTHbzUW/nu0UqP4G1scurJuYy4/sRIAT1VQA2bSIahYNduOlEC
         KnPL2vzubo0cFzfxmyUlRAaaxypnqYa6gk5vRFMQECg7+kQWi8Zivtsoda3hhiXOnIFx
         rVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m4ubhwdD7xWNz1fIp4dSNo/j/2+5i9zC1GJT/QlqxwA=;
        fh=N1LfIrgWMGUZd8zaC0blGW2UEouMKwLS6++ibo2SGd4=;
        b=XW3pLukTSU+vApqmIot46q7bx1XKa+NqEvbtrdB6tCEyCSKhXqD+TEY5qezBNS7Dwp
         FMeXAnryKwvyoVUPi88iSlFk27mx11x4GVdvLTRYn9nVkJhLRC5Ej2x8YozpCKWlHRwl
         Rs60hCh0wj0YPdtisIkO9czhtnmZ1DwST92T3t2APaV5t8Q7iK7pU9oWFCrAGHTk2D2A
         piUIwg61OFLCvfOwpXHFlFcvJuHaz7r8+1wTpSCqr0KwgJYus4t0gDRHccTFGGjLDAa0
         z8mt8g1lAuu5D0AalM5sDdcLPLa0UVH7rNzfuJsL6EHbyXRhzw0oIqMcGzzknhKwu4fV
         3axg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717211; x=1794322011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m4ubhwdD7xWNz1fIp4dSNo/j/2+5i9zC1GJT/QlqxwA=;
        b=YbwMCgGjapu2U4cW1LFSOzILIQ0bSem0oNun3PccpxdXy+Yp+l6dhte7Ey/vMaRasv
         mVCO5ZvXD+lirtIbu8AZKZDQWMWGre7XuicW2XukzMqcwRpWuHLWeib913i5htOazuvi
         zegXmhzyR9p6r9sL7PocqZX1FLzZlgRVDBjn/GvzVNnuon/fhKVuJ2MVF3sZvmpjzGvL
         o34ur4RGVmC5fGWdgDIAHxLYGYZoMSlbD6+ptfoVla9YKX+loStLyPGsoe+0FmT/9r3l
         2rDUfS9GmVdLWZttUWzZBfO1l2Er+tumP46uZi2ywLaQJcbLikbfrzHH8FHw7JPMWAOM
         Vz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717211; x=1794322011;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4ubhwdD7xWNz1fIp4dSNo/j/2+5i9zC1GJT/QlqxwA=;
        b=TERmpCg9yK8iJLQNo+1+zYtPE9o9Qb1DCVZDh3VN9XY42eu8w4gtvDRkAXE15QYnHi
         qKXnRAXE4v2MIUQfeSXZFUAO7QrHp9fVuizCWreLqHre/Qd7mQ5YxxHdI+0nOKl1MStQ
         HHggRIC/gro0ObLXxdhbpbHj3xJuuASNkzK9VokrvmtGeoE0gm9kpp2v2HgO1+rwfDZw
         HQhU5dSBKRQwS2SyFjzg/FjKDav3eV3DiRHSsQr5nV4Il5QkIpsMc6d0IW42eY5oTzCj
         F7NowXom13HXjMyTjBDyGSbWx7sFj4vyVwPHRcoKWPGpv0uQ24MPTUDOb3Z7S9R5//kn
         siUw==
X-Forwarded-Encrypted: i=1; AKwUvBygIpXSi1+JbLPGJH5s2xjSety+7H+F3qOV4TaJOM3JSM9hVO0VNnCgn0fDhurLI+iDAMXTDDuwiXaS/Tag@vger.kernel.org
X-Gm-Message-State: APuU4Z8Sg5AYMX36wwC73sdrs5+dWsf07ZtrurHldfLddkVaGHeP1k6E
	awnDftprWLlDTmyCGD/MVLWXlkeXCEcO1OWtZviwOhPUM/E4r4hSUZHflYCmFyfiP1dMPCtAjg5
	IkJzBg+hUI+BSCEx4OyWNavfoRRUST2E=
X-Gm-Gg: AYBFou11k0X2U4vlpyalZzSdKqU17ZduzME4coUfn0SIsB/YIUjmBauFQnu3JJP3D7k
	m0h8vhoyxZWZRGrvo+lYS0xnbQhdrw31dayZ7qOrAfziPHaAnpF+4yltVsy7Q1lgSIl5aTpVvQJ
	p/Jp1t5CF7BhT6D1Qhvg7gYsIEuzgTQgtq9JgCkyl0RXBnLr18hDRzeMeTZQltYp5jpgit683Zz
	VLsXtSSNDCx296Kp/wak5lFtEUsnTFBKVT1dQQTA2zrpsOO3ZoXMDXeJ+Sp0tXzmexd853IZQVf
	xOPmvON1nWtqIODG01IPxOhoThvD7XRa7OZmYS0Dk72X4HZsTWqAj7/E4NigwiZm3DesuyO4onK
	whxHAid1WqVWoXmmOE5QrgGsbX7iZB9cDYhm6l6fTuDk0qYGB+prMr4Bdb8S7dAzsS1RafA==
X-Received: by 2002:a17:907:1c89:b0:c46:8b51:c17c with SMTP id
 a640c23a62f3a-c4ca7a4e4b9mr1032689066b.17.1793717210181; Tue, 03 Nov 2026
 06:46:50 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <P58Wrer--F-9@tuta.io> <20261030-welpen-anbinden-nullen-b2432cee1d10@brauner>
 <CAOQ4uxjm=cGPnug18VuhKqiMvkWwLPNLO_TE3KxO8iLZG+veYQ@mail.gmail.com>
 <P5Qu3co--N-9@tuta.io> <CAOQ4uxh67+vs0mr-Lxmwz9-N+F8m29WUNz+8qFLLDpOVYB7=vg@mail.gmail.com>
 <P5WV0VL--F-9@tuta.io>
In-Reply-To: <P5WV0VL--F-9@tuta.io>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Nov 2026 15:46:38 +0100
X-Gm-Features: AclHuK-AkbE76i1M2E19O6SFPWAt7p_ENORS0HKIxbE5f-oUtF7Cy50LrWBo2WE
Message-ID: <CAOQ4uxjYX+A_xRBmfj40hmAcuQXwW4JPUmhJ9bx5ymSr0QoDnw@mail.gmail.com>
Subject: Re: [PATCH v3] fs: let backing files inherit FMODE_NONOTIFY from the
 user file
To: Edvard Conrad <edvard@tuta.io>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 2:01=E2=80=AFPM Edvard Conrad <edvard@tuta.io> wrote=
:
>
> On Mon, Nov 2, 2026 at 1:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > Good catch!
> > Please test the attached v2 patch and post the new test cases.
>
> v2 fixes the merged directory. An impure directory still deadlocks the
> same way: ovl_iterate_real() reads it through ovl_cache_get_impure() and
> ovl_dir_read_impure(), which v2 leaves without the user file, so
> ovl_dir_read() opens the upper directory with plain ovl_path_open():
>
>   fanotify_handle_event
>   fsnotify
>   fsnotify_open_perm_and_set_mode
>   do_dentry_open
>   vfs_open
>   dentry_open
>   ovl_iterate_real
>   ovl_iterate
>   iterate_dir
>   __x64_sys_getdents64
>
> That takes an upper-only directory that a lower file was renamed into,
> on layers that share a filesystem, so ovl_need_adjust_d_ino() sends it
> to ovl_iterate_real(). Passing the file down the same way v2 does for
> the merged case fixes it for me, on top of v2:
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -670,7 +670,7 @@ static bool ovl_fill_plain(struct dir_context *ctx, c=
onst char *name,
>  }
>
>  static int ovl_dir_read_impure(const struct path *path,  struct list_hea=
d *list,
> -                              struct rb_root *root)
> +                              struct rb_root *root, const struct file *u=
ser_file)
>  {
>         int err;
>         struct path realpath;
> @@ -678,6 +678,7 @@ static int ovl_dir_read_impure(const struct path *pat=
h,  struct list_head *list,
>         struct ovl_readdir_data rdd =3D {
>                 .ctx.actor =3D ovl_fill_plain,
>                 .ctx.count =3D INT_MAX,
> +               .user_file =3D user_file,
>                 .list =3D list,
>                 .root =3D root,
>         };
> @@ -714,9 +715,10 @@ static int ovl_dir_read_impure(const struct path *pa=
th,  struct list_head *list,
>         return 0;
>  }
>
> -static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *pat=
h)
> +static struct ovl_dir_cache *ovl_cache_get_impure(struct file *file)
>  {
>         int res;
> +       const struct path *path =3D &file->f_path;
>         struct dentry *dentry =3D path->dentry;
>         struct inode *inode =3D d_inode(dentry);
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> @@ -735,7 +737,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(con=
st struct path *path)
>                 return ERR_PTR(-ENOMEM);
>
>         cache->is_refcounted =3D false;
> -       res =3D ovl_dir_read_impure(path, &cache->entries, &cache->root);
> +       res =3D ovl_dir_read_impure(path, &cache->entries, &cache->root, =
file);
>         if (res) {
>                 ovl_cache_free(&cache->entries);
>                 kfree(cache);
> @@ -856,7 +858,7 @@ static int ovl_iterate_real(struct file *file, struct=
 dir_context *ctx)
>         dput(parent);
>
>         if (ovl_is_impure_dir(file)) {
> -               rdt.cache =3D ovl_cache_get_impure(&file->f_path);
> +               rdt.cache =3D ovl_cache_get_impure(file);
>                 if (IS_ERR(rdt.cache))
>                         return PTR_ERR(rdt.cache);
>         }
>

Right, I was being sloppy.
Thanks for the fixes.
I added Co-developed-by to attribute your contributions to this fix.

> Results in a VM on 6b4b543fa18, each kernel run once and with -i 2,
> with the backing filesystem marked:
>
>                                 file  dir   merged dir  impure dir
>                                             listed      listed
>   + c3d355f427ce                PASS  FAIL  FAIL        FAIL
>   + your v1                     PASS  PASS  FAIL        FAIL
>   + your v2                     PASS  PASS  PASS        FAIL
>   + v2 and the diff above       PASS  PASS  PASS        PASS
>
> The new cases are posted on top of the directory cases:
>   https://lore.kernel.org/ltp/P5WKBbq--F-9@tuta.io/

Thanks again!
Amir.
