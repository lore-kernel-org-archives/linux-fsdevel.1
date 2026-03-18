Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111D38D681
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826820; cv=pass; b=NOLHzBRWGBCDeOGamXZT1q0Tr3cXt9pQb2iV2GZAoxGukbgyw5xMdFGu3RUIPcyB25bogMLq7rbrLBtdeqbNvldzIqmwkIcaEm53a8pXUBTeI/She+IRNONf6dyHQEVDuRCugx8moX7UxzdkHA8+KC4A0uvbPic0GBHVSg6bvWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826820; c=relaxed/simple;
	bh=Jv8q9khYuN0MpmcV/c3FWP6Yas30BpbxTS8ReJ5p7CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYqowwWmMveuIuzQ9j8ft+j+p3rnwunZbYGHgFfbWz0d9qHsj6zjow0jyYtxSrIsk5TJmg8nZG6m6Lnqh9sqtZVHXaCR+3DiFmPAnAqzfFqDThskhf2VHlSWn+Ef2IbyV+3wQ97sN0b1YFIawYGM051TjuADKjbh4iB02ekLQVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Jf9c+JPj; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Jf9c+JPj"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd8c6e365eso694045185a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 02:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826810; cv=none;
        d=google.com; s=arc-20240605;
        b=HP9+jeIxpbb+XDvgjk5P5dwDSCGSPilvmhm9F6NCTtrq6MPlF8LrUBU14MRi7s8Z+/
         C65jJNOCgvhApHVpSbtay0jQtyya+08emIk2WODTsJbK1W9Yn8WfIiiTA27scddt0xkG
         JDawcJb6QaP814jBRWncVtjFHjxjCf3bu3Sw9uFHNTf2iTZh4GGfeQqNiOQeHBWiLYFS
         zF83iV85XBe953pXQ6DgKz9zpWkGZlYQ2NZHbip04tYQgfIj0+nKI8Et3JywJBQ8F1Q0
         +umyKV2/2csf+ADZZrrhVJJKPIFvZVHlHLinEv6SXErgHftFVZo4x2j1BYajm03ZJ1ZL
         q1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Czn01PPYnOyXqFYEm4x639Z4tH82uVvlvyj56a7wSag=;
        fh=glt6m6qXy9f7vtVil7oMLfrdUsHmVPSiyuK8xXl7Yug=;
        b=BywXe8dpXpmINCK7hf0uqD8cHkGyZfKyeIEPh0aBZdxBtEFndjpwPA1GfbAypC4DlK
         tDYRlGK0ESUgMo7+RtH3BEVRvZHj7ENo1dEdreC7IfdGCuhQNYEKbY/NI3c3+5O6px+o
         21p+jTuDT0yTkm/5l85GG8idgq2CV/ndpYL/5UHegu366DJ6ax2aUPeGXnlUYFf52VGq
         GwWd+lTNfKQH6d4G9X1wj4IxCOOKtnOQ9vimHgQrTqqW6htH/LDgWeVXr0+mpmnnNOyd
         ScrUy1VfmmtUhWQEwn1lQp5T21MIqHN1VcKoMTWYMbxvlcq/UgtnA87V5PDMJNEz6pL8
         zr3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1773826810; x=1774431610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Czn01PPYnOyXqFYEm4x639Z4tH82uVvlvyj56a7wSag=;
        b=Jf9c+JPjJ+1ADMuQIZ1F8bs4Wb9bqRCP6ebHeujA6/zbfpH/orSy4kcH0/f0G7QwQb
         W0n3BgzTYPLPGRlGorT3ESzFcrWo5ZmJ3rtGg8B2Zeum8SN8BnzXNn/5n/ePibUXRriH
         iaTKsPf8D/8XMJodKhME1Q/0f2oyr4TnCBiWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826810; x=1774431610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Czn01PPYnOyXqFYEm4x639Z4tH82uVvlvyj56a7wSag=;
        b=e6qEkFbqUPXdR0ZMnBLRZ2i63dxdKn040SDZw6MRPdzcG+gWJxOUxnw8xlsKrTpCQt
         +IYEhB5+YPZWTNAXK/0PYRJ6F7OR58/UZ1BMi/AzEJxjCl4EOMEeqstDGPSAYIidkqUf
         AGsXLtf/xvG2TNFHjwnIOl/3ef9cCM8XcGly1cxfBfort8vzfXbAIobI8cziEHRLk8PU
         4lIW1fs9WVyF8qkyyEe3GzsP26fWC4j4FX2lgsMAUhSNpMppw6n/9F1PjRjTdqwpH68A
         zyncHbh3amYWF+ZvEMAO0JB2+aC/67mT6GTaunDMK66OdGJwfMXP2yzUomUfnf5vuGca
         p4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnsvTOAeO7iVGfe3/iyUDmsAhkJV4cI1dYJudsGTWqUzhmv5Q+b1fhouN5sPGFnDGts754XTWeEhCb4hmA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14b5I6pRhECrfZjjph8Rgw88uVYqJwHaCbM6gh2zOefoDMQTL
	2zsjk1gHBpAHvOpSqCZR1vFLrKy4BxnYpCYGymMVKIK1zYvGCR2guMmlENB1z2Gy0FmiWNhtcw2
	OTlUBL4Up4GNSHRrERBuJHcmik7pp46yTqBvGJiik7w==
X-Gm-Gg: ATEYQzzBmFg5jr6cwLhy61tGo4lcZ2Fkz4+HBCmKuZb6KD1igcQRO0Ekb+spOH/GVP8
	kn60WXKd1qqZnfrzrysmmMBIWfbSAfbcpTArBD3WX91wQ2b2I9xwBskbpMZjsgMMySr7+M3cEEh
	ZAEBF6y09N35fgIojLH+hCBmsToCUTnZhrvMlco0idfGc/pDjVlRho+sS5vvD7jMrLrVFp4l3Xc
	C0f7R47gh2/r9XoddRhJ4Av258pN6tKvnFVs2Fgv2Eud5EQbnh3bPIU0aE6NGop4WC+6yxzqWl/
	VUxZjKwDwZFEpg==
X-Received: by 2002:a05:620a:294e:b0:8cd:827a:2abf with SMTP id
 af79cd13be357-8cfad3b71a9mr352029285a.64.1773826810554; Wed, 18 Mar 2026
 02:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316165320.3245526-1-mszeredi@redhat.com> <20260316165320.3245526-3-mszeredi@redhat.com>
 <55a31380-ac95-49c7-93b5-e5850fd23217@bsbernd.com>
In-Reply-To: <55a31380-ac95-49c7-93b5-e5850fd23217@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Mar 2026 10:39:59 +0100
X-Gm-Features: AaiRm50qj786U6BzNHw7QCHfSr-GooY8unG7IPfSy-1v684OZfZ4xowBc3IOrho
Message-ID: <CAJfpeguemLMcpGqodVf9wFtFTuJC1b7fkAmwfUPteJ+dkH2JTg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] fuse: create fuse_dev on /dev/fuse open instead of mount
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 at 22:38, Bernd Schubert <bernd@bsbernd.com> wrote:
>
>
>
> On 3/16/26 17:53, Miklos Szeredi wrote:
> > Allocate struct fuse_dev when opening the device.  This means that unlike
> > before, ->private_data is always set to a valid pointer.
> >
> > The use of USE_DEV_SYNC_INIT magic pointer for the private_data is now
> > replaced with a simple bool sync_init member.
> >
> > If sync INIT is not set, I/O on the device returns error before mount.
> > Keep this behavior by checking for the ->fc member.  If fud->fc is set, the
> > mount has succeeded.  Testing this used READ_ONCE(file->private_data) and
> > smp_mb() to try and provide the necessary semantics.  Switch this to
> > smp_store_release() and smp_load_acquire().
> >
> > Setting fud->fc is protected by fuse_mutex, this is unchanged.
> >
> > Will need this later so the /dev/fuse open file reference is not held
> > during FSCONFIG_CMD_CREATE.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/dev.c        | 47 +++++++++++++++++---------------------------
> >  fs/fuse/fuse_dev_i.h | 33 +++++++++++++++++++++++--------
> >  fs/fuse/fuse_i.h     |  6 +++---
> >  fs/fuse/inode.c      | 35 +++++++++++----------------------
> >  fs/fuse/virtio_fs.c  |  2 --
> >  5 files changed, 57 insertions(+), 66 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index f0631c48abef..fe453634897b 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1546,32 +1546,24 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>
> I have a question about fuse_dev_do_read(), is there any risk that the
> compiler might re-order and put the
>
> struct fuse_conn *fc = fud->fc;
>
> before the "struct fuse_dev *fud = fuse_get_dev(file);" line in the
> callers?  In order to be absolutely sure, wouldn't it make sense to have
> a fuse_get_dev_fc() function, that also returns the fc that was acquired
> anyway and then add this to fuse_dev_do_read()?

It does not matter.  The sml_load_acquire() means no memory operations
can be reordered before it, see Documentation/memory-barriers.txt.

Thanks,
Miklos
