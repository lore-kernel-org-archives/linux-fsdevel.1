Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CF38F252
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655465; cv=pass; b=tBc+gfbHRirfLEmzkfk0q6YcCDfGS0UNu4QgRB1q7SdHWMLi/j+tXa74Y4QP4LDTkcImOkIbCHi3Rph+Fw3wfMapMqoybjP+m50iLnpU4HX7DKSGlzjizA920JG0fWwOiEoGgGRlHbbkjn3+9CzI0GjtAAI2pDn+0e3TJHqk+bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655465; c=relaxed/simple;
	bh=HfHr07khlA6YNqB+5gImEHWdRrJzJu+1MNHp0nTafA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVGZc/fYel/MzZWycIaMbxLZ/TkkCBLjV6AqlO7ECG75OqmcKpBdSuKY+8p+QazP88b3TZVkwK42zea6/ALKpYYcpFTIy7NtIexP/dwNFGTZjbFb5wqyQ3oHu9uikRS66vAuqYAFOGAWrGFw4UowDnEhmuZy8+bcW9CLHzo2+Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=B5bLE9Bw; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B5bLE9Bw"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd80f56b27so394991985a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 03:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773655461; cv=none;
        d=google.com; s=arc-20240605;
        b=Or31Vs42U/CmsGy7eceYgVeydO6L0+U0MNQiBYUWznY2wVCUFNhNED40qEjbru3nnB
         zFB7kR/jeMN/0pEdJ2oyzi+e+GJ1QzEFvFDzov9rma1EEKJsXmLRqbEYcrHGSKrTsaSQ
         XIEsu1fO8PfrIycjp324eRjXwWTy6/htHUeCOY7V1iMymJU7UEp/D+5uCPOUycf9wAGT
         5rAhzt4hPTm5P+zDBgbNFqHs5+IpWibsnV//Jt44hnohgIgxND/Bpf8BFBtmvIZSGXq5
         3HKyV2/efCN2s4dXYqA3ndbWfF3XedNzB+mXwZHRm8sZBYfgFlmelTIeP2kmkDycujEM
         aaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hs7lqkCHKPY+mfqalV1eQQCfii5yPLuRlqp7aaUHxUI=;
        fh=KE1DWPrdOMT4XLVGxnX52x+PXUPDj2OfHTYlQwR52NA=;
        b=gKOMsT8sc81Ff5nrc6HHPY1uTu/N4I6ZlKK4HQLUt+xFmnLMS+iPKDgx+//bWb5lBW
         BvR5c3zjO+yyqe5lB90ZfF4hV0zpN7gim6rEK7X1BbLnuq8U+AVD12hNzMUMgu4BsFrM
         AurXd9OVDryLahMninlDTSGeg5/CU+9RjKTXeNQ2edLQ8rdsOaGWGOQ9zD/HstdG36KB
         40Scb+hFGlC1tPHN05C8lrK1EEFbHveUoHq+N8r5041nFFUgOe4xtq/YbuZlPIeR9D8C
         V0iZJ5drbjxxRX4W4d8sdlh/BS7AsJWWKeOB3Irz26zLpiMsnn1xey4EGcRsj9P7BHzw
         J4Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1773655461; x=1774260261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hs7lqkCHKPY+mfqalV1eQQCfii5yPLuRlqp7aaUHxUI=;
        b=B5bLE9BwYsVqED4fv1OuEH8wIC91J7n9IUCsqYd4zZP4TNhsrxK2MJG5NUjamtXQ7K
         K4R54P2dCuQZ5O+5iWUNr9Cex9AxrqLId73O/P1RSxZi9SkYREUR0u3YzcMKQQ+CLa+S
         R34DjDIZEIbdi1VgEpA8/dtT2OEhNvifv4Bh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773655461; x=1774260261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs7lqkCHKPY+mfqalV1eQQCfii5yPLuRlqp7aaUHxUI=;
        b=a7KNBLstfyPx9RWYUPHTNvHkST5FoStmRAZNaHHbfcjUNRBCgHHy7/QnpPGQgh62Jl
         zNvYTRMvTsDl3KDnX6P+CRvYZyrQnQRjbYMOPBgKW0SO4lgs//qiMtdFIOoZiyVA3S6S
         FuWjpuvmx/Iye7J/DlCpz5LeGAu36+17mT3MObGHBcwzkn4LW5jGe95OylYhryDLWjYp
         a44kCOvOxux4ukRK1NzCErh7HtNc7w98vFeLoetzoqsc9jPLTcgRGq/3lpKWFxajmDyP
         71Ko8ojnS/EIrogppC++YIfXbDYdwR6K3/s+FIyvlUNMCAEIlqIjC6CLdFXkutBsny2W
         7W3g==
X-Forwarded-Encrypted: i=1; AJvYcCVtwi/CalvvxYEg8KgD+GU586vgbX4+H/pqJ68U/+QVXqcdnI5PjVJUHUPHNmziAt78mKgLwtuOUAXuT+c7@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJYg1NQmcNxgLhMAn6bYuoS/XICNa0a6zXBqB0PedsEa8Mzjl
	yznCaoz6yfNOE6OLdnODVm88BSEotebwg2djcchUg15Ccv7m7+IkLtfrf0CNGjtCw3ft1Go45kj
	gHQj07gG9r/7CxuMCtRIk6jCU1iPd16TPycqWn0mwaw==
X-Gm-Gg: ATEYQzzD8QfSZz9f90nr+hWCGwZ8qav+7is2RGtn0kGelZL8J2yUR51wPnFmNfZuB46
	AhdF8H7e1IVg9EZtOZENUjkEd9WtuqQiKyG5mv+sKjFIjIAlwdLbh/sdb4VlVuAn1aT4u0eHSOT
	VHi4uIBaKpmJuQjSpqfcVCFCcSy/UNtZQvXNK6WcxBnW/ZliajxrmfII/DTh+nVqukXYcWfh/RX
	eVXMR0gCeEo5ZzQU409PjAnA6BFubDUWy1OyqSTdkdI1k2JIZP8pjLZowV99U1qLTIZg6E6/GNd
	JJVCzA==
X-Received: by 2002:a05:622a:11c3:b0:509:164b:5b41 with SMTP id
 d75a77b69052e-50957e3b4e7mr150653811cf.70.1773655461184; Mon, 16 Mar 2026
 03:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-2-mszeredi@redhat.com>
 <20260313220506.GE1742010@frogsfrogsfrogs>
In-Reply-To: <20260313220506.GE1742010@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 Mar 2026 11:04:09 +0100
X-Gm-Features: AaiRm509sD0oO4kPSo_Ix6pcZBRMm0udNPFZ4lpyl1HCQiUSvZlyQP7qnB03kHA
Message-ID: <CAJfpegsyp7a5oDxYKdLeGZ6sXcmim1Z3EE8-0NeP3=KCaC_6Lg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fuse: create fuse_dev on /dev/fuse open instead of mount
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Mar 2026 at 23:05, Darrick J. Wong <djwong@kernel.org> wrote:

> > +/*
> > + * Lockless access is OK, because fud->fc is set once during mount and is valid
> > + * until the file is released.
> > + */
> > +static inline struct fuse_conn *fuse_dev_fc_get(struct fuse_dev *fud)
> > +{
> > +     /* Pairs with smp_store_release() in fuse_dev_fc_set() */
> > +     return smp_load_acquire(&fud->fc);
> > +}
> > +
> > +static inline void fuse_dev_fc_set(struct fuse_dev *fud, struct fuse_conn *fc)
> > +{
> > +     /* Pairs with smp_load_acquire() in fuse_dev_fc_get() */
> > +     smp_store_release(&fud->fc, fc);
> > +}
> > +
> > +static inline struct fuse_dev *fuse_file_to_fud(struct file *file)
> > +{
> > +     return file->private_data;
> > +}
>
> /me is no expert on load-acquire/store-release, but I think this works.
> We can't reorder code below the store-release, which means that if
> anyone calling _fc_get actually sees a non-null fuse_conn, then the fuse
> connection is fully initialized and ready to go, right?

I can't claim to be an expert either, but yes, your description is
exactly how I understand.

Nits fixed.

Thanks,
Miklos
