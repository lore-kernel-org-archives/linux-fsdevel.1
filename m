Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86A37DE84
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703564; cv=pass; b=mmbSSVaFFj8cM7Jbk61U1bK7mT/w6CCNkdtJefUQst4R6U2kIEkJjBcsIEtdpm1MKzXjbGVbXu6hWH0mVPRQBgowX9Nys7BXc73Wc4GVd428/62uJyo5JoXEsMz6L7v0VxJTLLs/YRN6xvIZ+G6o9qcwuni2gA7g9zezozNBjYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703564; c=relaxed/simple;
	bh=J2Hz42O91fDPdzwg6XddPJKM8N13SVO3bVw+i/0hX6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cP2ta6I10Zt5tQ+xGfsIfNQfBVCSkk9pBVyMRqkdAblxo3Y4grzgFOM841xTyFj7K01SiMTEeewTnQB4BJi4Vb8PJCTNgto16eww0hHSiC3FaQoCU53L6091m6rsjLiGWwV3L+vy9wcLxBoYJQlE2pdmbjb6vZpDCFRPCqWey28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU6bkUbj; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU6bkUbj"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80dd4766206so5862767b3.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 20:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782703562; cv=none;
        d=google.com; s=arc-20260327;
        b=EgplY7s/PzvE30et7lQIaNQt1FZYhVwhsQMZbh+Yj75xUM3j3+iIhYEd5PIze+bsVt
         VKEO0qCStZ4KVNZs8sVuVRq1D5xNTsRmyVWErQG3eeweHarixpysLvOoBS/oHiFh4Rbd
         k49OqNQbko4T6qCtnN8GJ0uJW7RjVBj/o5CAXURJ40KmzVhWGUPULMDY9tPgup5mlf2T
         6si/5JOsSargWXxTGmprA7FVXLTczZTNl/prqBRtkfoZAt9YQ5hWRWOr0xCIkIYqvz1E
         6EYZDO5ZuYySnGjzat0DfbG6B8Fk8WvzWLyLnroDyEbhAwY5PGwHOs7vILNrftcvRjG6
         IZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J2Hz42O91fDPdzwg6XddPJKM8N13SVO3bVw+i/0hX6Q=;
        fh=mjI1nYcL00LNdwOmEqsVgBaqz02xVpanq+bmuUynfD0=;
        b=BPaWpDF92IDufAFFHNgVH9tPz2mfJ/Ml9NjNMz52lCA3uK/b0g1Z+nJkbcevjectpR
         P1pQPAS+eOFZSGDRSEcPd7iohsckcKaZB2X5wBTXMvfY8rgiDETLh6Z/16zP6GSbMlVB
         YeJ/1neR87cQ8z6xG0meN5lUO78ILGHzmnN25FjKOjOgnOzR3NeCNgF9sldN3u/NB3oZ
         Wd7JHoPn3oEZ/2um9eAtkwbRJpRhubGPzDdfIVhFahps3qdhugMZ/oSs+j4iMLNxBRO1
         kxJPut13kelem3+pBg+epSrMUoKH3zs9rJlZk6Dk3JBIhEY4zt+1Hnl0jQZIElER4Umv
         8FkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782703562; x=1783308362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2Hz42O91fDPdzwg6XddPJKM8N13SVO3bVw+i/0hX6Q=;
        b=HU6bkUbjys5eZxXQ8aGhF0YsAcpz2ZQFq9ON06SmE4cC4tSaDvh4WhIlk6h+3zusyr
         SDUyx+jnEuCAY8uWPuZttidVdAMrkX3X5NE9zSh1fArS7GOmwLIVaIZGO9eSvMGVR0Lm
         PgRcnIDFy/vRi/wIXQ/ZlUI9d1+6Zx906GyJ9M+r93ameHo3tCDhZneuBsgg3loh4vz5
         JXJ49XbPnXm6N2jNZKtQCEyC8jQeNk64D/bCf9yGhISE8ECuLB0RUwlIIuRsLhjdlSmJ
         FyyuxXnMXt8ssJYGQfTbHFUw/4724pZbLZUy4cX4eXoZQBAJ0YnIEY2kT95hO+mZOx9I
         AHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782703562; x=1783308362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J2Hz42O91fDPdzwg6XddPJKM8N13SVO3bVw+i/0hX6Q=;
        b=SOmpoSQSCtEuJDYLA+CC0pPQlzZ4De6qyMLbyzHNIDh0vKb67XYfFrjkHm1x8vHiYp
         BqVUxhRILxXrhCz/D+TLwBafdeblmxc4vtTE4PGGk/nRCJgcGktsN21Zhax2Mt38U11v
         3hi/DAGFVElVu43X3QXpnqGSsfL4M1+kk67U2sR+IpWne4i16qFKu8CtaEb9dH4shJvU
         6zzbiK1vBcX1ynxdNUkvmv39W1Ty4aOmNzubWtaEykTNjuTDeW9+yflqA8/G9dNx6J8R
         9D4ilJ289J6VGyq0NQLlTwFwXl/FNsJ+sHYCWuMX+cK5s3M3xGiw7J25ImzYFWuv5C2z
         yG+g==
X-Forwarded-Encrypted: i=1; AHgh+RqQ8zlrCN0d7HTPnA0d62KsJWHb04LqC9WBTd2aN35zQsmqkmk/ma+ecZ9N8/pdv65qV4GkEpxjtX4Ujzrr@vger.kernel.org
X-Gm-Message-State: AOJu0YysJhvIhR23JAi9EBYiDUZgopuozC+U4S15wYnHJUsa5a+cd0EL
	6s0KslnF76AGFd4KF3eWtLAwoHaFGoN+3q87yddO254ux5ZsGwgMhl8I2kyaQd2NU1H+UhVmqQ9
	2PqFBi2BbURy8dUqn3ChFtoA+bZ3uYGs=
X-Gm-Gg: AfdE7ckUt5iZJsq275gZ3IA8XsG4ctxWW41aE8Nt+OB8QnCYFym7NleeHVsvXr1jPmm
	LG+BBhCu8Fv7mo+mUnp7xZ7tCrEZx3eBupyOiyoewLTQG0WhwKwLnWE3dPtr0qvdBfWNxdNiP8E
	nWuJx/L9DhMfMYbifoAJXC7wVZrJlpKom4wXkTXObY0zKKD5n6iaxOvxdAZAfBIUFnmZQ5d8vG7
	qfWa8rXMvkz2Y0uRDzrs6IOdczdRcV/yBchZCugVWKmCPnV6+sMGDvldxKhVTzLG0349Fuy4gw=
X-Received: by 2002:a05:690c:4446:b0:80c:8596:464d with SMTP id
 00721157ae682-80c85964947mr89367387b3.63.1782703562562; Sun, 28 Jun 2026
 20:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627042816.2842609-1-zzzccc427@gmail.com> <CANFS6baiHaz-U-uCPjh2oERc5TM8yU1OHYEN3WJ3KbXS524M+A@mail.gmail.com>
In-Reply-To: <CANFS6baiHaz-U-uCPjh2oERc5TM8yU1OHYEN3WJ3KbXS524M+A@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 29 Jun 2026 11:25:50 +0800
X-Gm-Features: AVVi8CfrlKMbs6YC1-HNqGZfJ8L2Mx1xzKUyxRLJ-BEee0WjkH7KcV91V4foLdQ
Message-ID: <CAFRLqsXpNbK79g00+nE1+cOmvSAnAP7+5dB30onDGjuGOefeBA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: serialize attribute-list replacement with lookups
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunchul,

Hyunchul Lee <hyc.lee@gmail.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8829=E6=97=
=A5=E5=91=A8=E4=B8=80 08:29=E5=86=99=E9=81=93=EF=BC=9A
>
> I reviewed and noticed a few concurrency issues.
>
> * ntfs_attr_lookup() releases the read lock before returning, which leave=
s
> the ctx->al_entry unprotected during the lifetime of the search context.
>
> * In some functions such as ntfs_attrlist_entry_add(), the memcpy()
> reads base_ni->attr_list outside of the writ lock. If another thread
> frees it concurrently, this leads to a UAF.
>
> To resolve these issues, How about coupling the attr_list_lock directly
> with the search context?
>
> * Extend ntfs_attr_get_search_ctx with a lock mode (NONE, READ, WRITE)
> to automatically acquire the lock unpon context creation and release
> it in ntfs_attr_put_search_ctx().
>
> * To prevent deadlocks, the following lock ordering is needed:
> base_ni->mrec_lock =3D> base_ni->attr_list_lock =3D> ni->runlist.lock.
> And to prevent nesting attr_list_lock under runlist.lock, The NONE
> mode bypasses context-owned locking and is required for paths
> that must control ordering manually (e.g, ntfs_attr_vcn_to_lcn_nlock()).
>

Thanks so much for your review and detailed suggestions.
I see the concurrency issues you pointed out and agree with the
concerns. I will revise v3 accordingly.

Best regards,
Cen Zhang
