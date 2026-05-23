Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6717A2EA
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498390; cv=pass; b=Ge4jswCZWlgAQ48psb38VzHKYyODdWwuBy3wwUssLAYiU8t9cnXQvt0KeeXApNJYrzZff53DBYNmSmd6J2wagDPCyMZnPksmiEATzgfDfl11bVvQDtnz4mEzoJhuuIgFikQNiTKKe2GUich4E5ciWjmC3FKL01f2SJ9pGjGRvdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498390; c=relaxed/simple;
	bh=008arDp8vvl2EH8wWoKU9y05SBL71K8zEeua9ZIvMAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbWfrA8iXSJo8qzN4KA2d4bpTofzebV9DySmwHJfcig5Qk+cUC+frVaA31HFnz3tRC7TpDNmITJN6GRuZGlTRdLmwGUMhaTzfxuzdboZzS8jAJrGwd8KzsbSAW8sjtsYc8tB/JjAnaUKRr9ztTArBSoufZB3gTB6e00KWTcShjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M346ISVX; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M346ISVX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso101449815e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 18:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779498388; cv=none;
        d=google.com; s=arc-20240605;
        b=H2prFcCXf24y18EbIW8s9wA3yusdCglJxFGiw3IWMu3jxTP6XDpiexKr9FNwODFQ5B
         RFwqtLCdqLh9JUxA5HqCsvlEN1cS15y5ojSVvc0JWUoZNvWqzUwaJ4cYW9Dc4GOP3lXw
         Z4vPt/VxGPcggKom35gNnEMSk/hCYJzEZkLvT0fMXAFeL11cESMvwwk6RlxsAIKvj2mi
         clKnXrM7rpoUaDY4JwXMsprTGlzK19zDNM5OH//sbPkSzDFeEBlKS241AsUc67enUjT2
         ZTl8Omfu6la9r9HCBNmcD6mCqq0Em4Tvmd1c9b2vOjpAwwkRLnBEhnXSCIISRSRj9BVV
         AEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7G4sWsoHD5+tNB33FsWgjk9NhMBuRi9WIelOtZhiH5U=;
        fh=7zGacbxBkLl4aiTxp+CILbKNCaB4r2QjbTP3RnUO9b8=;
        b=P0l83VrgVrl2yzSZhcZR9w9MPbWBEb6yv8plGzJRrV6Mv+ny/vwp6QbvMw+N30Cet0
         dA9K/h8xqq2LIbD0MbBVwJS+PUVkKbSi2JpOoqU4vK9mfQoS6lpFy5Uosqacp7cPzdC/
         obaZKcTDiLFHrPE7fxcu9zQ2ffPK1uvJ1F/LTd7+icsMLep54IHA7KJ4u3OV/Dtwq3wC
         gEvviafayNxhK5ggkb9AFy3cgOuuCxeJaakRRX68O+eQjHnekBb5LhTXS795PUs1/23L
         6ZxPzrwyI2mUbqKSvaCIM3mrmSkXo+bcfjVDtm6lu+pePWGLXR2eR6uwWhX6CFZAyAHS
         uFXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779498388; x=1780103188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G4sWsoHD5+tNB33FsWgjk9NhMBuRi9WIelOtZhiH5U=;
        b=M346ISVXk4Gkjs2NNbuf6K/04kodzTbBB7EsjkvvPuqD/8iU6PDTqqXezFvX+LVuCy
         v/FTJvTFfUPsfTX2ORvDIMNIdlYMF2l8VpgIK34YFWSMpqBQ2oOBkeLETEwe2N8+F0qF
         rRvpFtZYqzftzm/GLsLO+anhj56L8JD6eONQsTrtq204Ga0Qe1WNsVjYTFk7DedQEOsb
         o5hdvdMPTwfa7kp68VcupmLDBjcqkE8rt/GQhsK97YVaeylwW88Q/Pvynce3+wj0fhPY
         ZYCV6e3i8che1cd8I7C9CjSMcPhP8kSxpsGDSNwxbXVlSDgpq89ok1hbg6UXv4i5STkd
         VXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779498388; x=1780103188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7G4sWsoHD5+tNB33FsWgjk9NhMBuRi9WIelOtZhiH5U=;
        b=E3aGl4c6wh6IjaI7N8rMbfN+bJq9FTo3Je2MDNgfbEPSGDcpvTqUsSJ+ZmkYC43NBE
         M8AiYW7LLiwYq9vSz4w0FHdBYb9Day061lhPU3sINSTCfwa/PlxEqACs39dHxa9vruvx
         IWmrMMS3uOHjb0ryNQ/7s9BOXM9v3NQemX4VYnzhmkin2m9mRYP47/BrPirUxYigH/x+
         DNQN3kO7oxK1gK8Vn7VNUhfVn8dHuEukfmDgidhksOMW3vGE1GvwGHYZ2Qn36BFic2AB
         A7ffQm8G8NNT3LtjCDfYyOiTNW1zd5Owjw8P957w8ByZdjBFnz7kDRuec2PlY5uFq3Ow
         LAFg==
X-Forwarded-Encrypted: i=1; AFNElJ9rTVNxhcqOalrp2cJUg6irNNyTm7zEwAAuHtIaLXBlsJNQtdEm5giTStqV5mJdN+HG0P83vVEuo65ws10e@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3x29eXf3xs1/hnwNLGly13Po/nUqfl+l1xjdEMIFAbx7VvcTT
	4pRbhKLvd6oMonLKE69a/RNfRTG3wd0xbVkc3jNCVEOkFjwfW87aT8nNYuUPg+u64HpBjQxuuOj
	87GPGDGIM/DoTxeYg/nOUpYDnFtqXqJk=
X-Gm-Gg: Acq92OFyJUZWgAT+TgHwPn6qeQ59mggcyE5mpfcR3i1Mm8D9uE7sF9cgBjZmcluEOqX
	UFpxuN56PfgmlUfhqlhPQ9x3PxaiB3h6EFFdnZUaRVwdS9X2jXQuhDinfZ2TpDOwkZsBCAJF84b
	bMAJQwUg44v4ESUj1wqRlBkpPzIlc4XAuRk2HA7iJOBfUy9EIdiZu1YMgBeW5XK73b7VUKmKWNE
	OPTLjwE2YNNWWr14HPCfX+n0+KlHC+kjqSq8qGJK/2o80r62DgEKOcdtkkme7TmWrG8sinSFA6z
	PooIsiQnPBHwK7mF
X-Received: by 2002:a05:600c:8b12:b0:490:5191:6e1a with SMTP id
 5b1f17b1804b1-490519170d7mr7796475e9.24.1779498387457; Fri, 22 May 2026
 18:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs> <177922946372.2439242.13829037107289830266.stgit@frogsfrogsfrogs>
In-Reply-To: <177922946372.2439242.13829037107289830266.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 22 May 2026 18:06:15 -0700
X-Gm-Features: AVHnY4JgP4gSwmN4FgBMIFrOf4UkX3I3qaORsxpu8HZHoxK64s5u0FUTDQvEIVo
Message-ID: <CAJnrk1ZQbvCL=ok4WHBn0gC+=k88Cejts_-_DP3epa51Wz5+5g@mail.gmail.com>
Subject: Re: [PATCH 9/9] fuse: set iomap backing device block size
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:33=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Add a new ioctl so that an unprivileged fuse server can set the block
> size of a bdev that's opened for iomap usage.

If I'm understanding it correctly, doesn't the fs/iomap layer align
all i/o to the fuse file inode->i_blkbits and submits bios to the
underlying iomap->bdev without ever reading the bdev's
inode->i_blkbits? Why do we need this fuse ioctl then for setting the
block size of a bdev?

It seems like this ioctl is re-implementing the BLKBSZSET ioctl but
bypasses the cap sys admin privilege checking that the BLKBSZSET ioctl
requires, which seems like a security violation. Am I understanding
this correctly?

Thanks,
Joanne

>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_iomap.h      |    3 +++
>  include/uapi/linux/fuse.h |    8 ++++++++
>  fs/fuse/dev.c             |    2 ++
>  fs/fuse/fuse_iomap.c      |   27 +++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
>
>
> diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
> index f40d202c64c822..3cfef073cbe5aa 100644
> --- a/fs/fuse/fuse_iomap.h
> +++ b/fs/fuse/fuse_iomap.h
> @@ -69,6 +69,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
>  int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *ar=
gp);
>  int fuse_iomap_backing_inval(struct fuse_conn *fc,
>                              const struct fuse_iomap_backing_inval_out *a=
rg);
> +int fuse_iomap_backing_set_blocksize(struct file *file,
> +                                    struct fuse_iomap_backing_info __use=
r *argp);
>  #else
>  # define fuse_iomap_enabled(...)               (false)
>  # define fuse_has_iomap(...)                   (false)
> @@ -97,6 +99,7 @@ int fuse_iomap_backing_inval(struct fuse_conn *fc,
>  # define fuse_dev_ioctl_iomap_support(...)     (-EOPNOTSUPP)
>  # define fuse_dev_ioctl_iomap_set_nofs(...)    (-EOPNOTSUPP)
>  # define fuse_iomap_backing_inval(...)         (-ENOSYS)
> +# define fuse_iomap_backing_set_blocksize(...) (-EOPNOTSUPP)
>  #endif /* CONFIG_FUSE_IOMAP */
>
>  #endif /* _FS_FUSE_IOMAP_H */
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 899964f8d6616a..0b67938bb7baf0 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1173,6 +1173,11 @@ struct fuse_iomap_support {
>         uint64_t        padding;
>  };
>
> +struct fuse_iomap_backing_info {
> +       uint32_t        backing_id;
> +       uint32_t        blocksize;
> +};
> +
>  /* Device ioctls: */
>  #define FUSE_DEV_IOC_MAGIC             229
>  #define FUSE_DEV_IOC_CLONE             _IOR(FUSE_DEV_IOC_MAGIC, 0, uint3=
2_t)
> @@ -1184,6 +1189,9 @@ struct fuse_iomap_support {
>                                              struct fuse_iomap_support)
>  #define FUSE_DEV_IOC_SET_NOFS          _IOW(FUSE_DEV_IOC_MAGIC, 100, uin=
t32_t)
>  #define FUSE_DEV_IOC_ADD_IOMAP         _IO(FUSE_DEV_IOC_MAGIC, 101)
> +#define FUSE_DEV_IOC_IOMAP_BACKING_SET_BLOCKSIZE \
> +                                       _IOW(FUSE_DEV_IOC_MAGIC, 102, \
> +                                            struct fuse_iomap_backing_in=
fo)
>
>  struct fuse_lseek_in {
>         uint64_t        fh;
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 06f52114b9aef2..d6ba8d6b1a8875 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2746,6 +2746,8 @@ static long fuse_dev_ioctl(struct file *file, unsig=
ned int cmd,
>                 return fuse_dev_ioctl_iomap_set_nofs(file, argp);
>         case FUSE_DEV_IOC_ADD_IOMAP:
>                 return fuse_dev_ioctl_add_iomap(file);
> +       case FUSE_DEV_IOC_IOMAP_BACKING_SET_BLOCKSIZE:
> +               return fuse_iomap_backing_set_blocksize(file, argp);
>
>         default:
>                 return -ENOTTY;
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index ba54eb694dbbac..2deed4749738cb 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -2448,3 +2448,30 @@ int fuse_iomap_backing_inval(struct fuse_conn *fc,
>         up_read(&fc->killsb);
>         return ret;
>  }
> +
> +int fuse_iomap_backing_set_blocksize(struct file *file,
> +                                    struct fuse_iomap_backing_info __use=
r *argp)
> +{
> +       struct fuse_iomap_backing_info fbi;
> +       struct fuse_dev *fud =3D fuse_get_dev(file);
> +       struct fuse_backing *fb;
> +       int ret;
> +
> +       if (IS_ERR(fud))
> +               return PTR_ERR(fud);
> +
> +       if (!fud->fc->iomap)
> +               return -EOPNOTSUPP;
> +
> +       if (copy_from_user(&fbi, argp, sizeof(fbi)))
> +               return -EFAULT;
> +
> +       fb =3D fuse_backing_lookup(fud->fc, &fuse_iomap_backing_ops,
> +                                fbi.backing_id);
> +       if (!fb)
> +               return -ENOENT;
> +
> +       ret =3D set_blocksize(fb->file, fbi.blocksize);
> +       fuse_backing_put(fb);
> +       return ret;
> +}
>
