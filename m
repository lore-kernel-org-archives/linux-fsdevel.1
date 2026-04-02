Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60AF2D5432
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159571; cv=none; b=b/t1qeEXI1p1UaEoQPce1eefK7ne0XIBTUCqtUAZxF2QUQ/5I2rkCY2RuOV1iMqvtr4Porr8+Q+xxPHMv0vXvhxJAJb5qHqYPpAXqEB6G6pAFcnYUaEdf5kYdGDHgsM3MJxW/961QE3cG6hwmEhrmsaNM7nH3JaCbvN5XeRKFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159571; c=relaxed/simple;
	bh=iNiJfE+71j2E2TswePUZNMfvxG6gXb5alsxVDR/V7l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smhJ1pqyjmQvUzfViU26Qln4VzYNBugOyDcN0BYEwXNAGBkuEf8n3WKiKub/MxomcyhxVP5x+3sLX1gux/E+k0d0N8BPRzopH2IRUYD56knY7xoOXaqs5cmtUW7d/FhG+e6wlGDIVAqvHU9xfAFJOm+67gKJZ0zVpYkcVlnnYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J+UnULAb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J+UnULAb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b941762394aso169921066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775159568; x=1775764368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KmkQSaQCu3P8CG3k0cZ/LMbZUuk55aVQgzwh+RtQl8o=;
        b=J+UnULAbzdKhcVDBRivgGzYUaB6vyFvw1t0q64PqhZf/ThRXI5c65UKAoAzvNRG5P6
         87zmHSRwVLil9E05El0UaYWeu9ztqpx3k3DSiszyfDtVs2VPai/o3cc59kCE+Qw4l299
         DTIZxLv2czs5ZfFQGIMx7oYrvQz3/xFpkYaXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775159568; x=1775764368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmkQSaQCu3P8CG3k0cZ/LMbZUuk55aVQgzwh+RtQl8o=;
        b=XsRt/muZLobEu143mXQGOvrPu2DC4c/n9mgOSo4povEAu5gWpU2iyDSzd+x4JS2TfB
         9Rux1AhRMvgENLx/87XwZZkX+u2o6mdrSlRjuqWMcIAmnIg3LRBu2Z5ypkfD3nZ3F0kq
         yvue5lyRbkQdrfKeVhYB3Y0Cbg0ScYjObrJxffyxr/EYysHbtSwlm/HTx4u4UBB3QW/k
         vC2+WPkvX2dDLjvHu4n6ACu5M3uK4pvROKcC2mGic+54Lf8+rbwSsFX6r3eW3A6Vmg9F
         GN2g9zhBpY1TA+423NbVffxApSK7yf6ebo8S3oE72uEMRot91HyCCouLEFH+6DBRMYRz
         skkA==
X-Gm-Message-State: AOJu0YzoUtd7O+rsuAefanM2EThkg+9F4teNMUgsvGDz0FlD1TTYhad4
	K4qcsQCJkTAB8KnJir7umGEvmn7Pr5iJfJj/QxOaUrBgjiYPjNGgnxRea9A/2E5mFnO39ziXDtp
	MOb373Ns=
X-Gm-Gg: ATEYQzyHRguJQJZdl5SESL1xdLwx/W46pnRfP4ca+0sJ1e5eUQc6BUu69oP0j6beBGY
	DHHp4Ugj/6amL3D4rLdk9LEZC0kRgL2+LIGe4VPixc/PD3uijsS3KHy9KqZkprkJRDJIFVyPLP/
	xAeB+3IwmAJSw4C5SUTsJyJ4CCwHhypPm4uy79wXRzSuvaRf5ESJSYjuFAMPK22k/AD8obJsX5K
	p9BtaX/rUqKLpjRCcVrUsZLbA9RxOMGIyX7irm5yq/6vIwQhLYi+fDGRghGlP2dnSvMQoTT68ZL
	iaU2LwUyStAuGa/ndQfzD9WE0Wyo1PYOOPId8XNfN5GKOPsYCstlqIfHtnpb7PNaPju85OZCkAH
	ldySOHhztkGGf5sYweukd5taUR/nsZ3YipqtZfnM5x6/vlY9T7ZigRavq1uIOaR6jUPHnr6IXuu
	vhbCPl9e/oq8Z7I/fUeDEU8w47OMhKf3TAapaK7hfjO+XgeODKLHB3AKMORt4It7nCUGrX7Z88
X-Received: by 2002:a17:907:8703:b0:b9c:30b8:dcad with SMTP id a640c23a62f3a-b9c6795209cmr6014466b.34.1775159567802;
        Thu, 02 Apr 2026 12:52:47 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6c31sm125213266b.37.2026.04.02.12.52.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 12:52:47 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66bb7e098b1so1447266a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 12:52:46 -0700 (PDT)
X-Received: by 2002:a05:6402:388c:b0:66e:2e25:9309 with SMTP id
 4fb4d7f45d1cf-66e3f3c7e60mr189454a12.6.1775159566537; Thu, 02 Apr 2026
 12:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV> <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk>
In-Reply-To: <20260402180850.3729310-5-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Apr 2026 12:52:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
X-Gm-Features: AQROBzBaeVhYdzZH1UJdCtiSfFsxMwPpR1MPqmPTWT-R__b0nc2wThyBAvQEoLE
Message-ID: <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in shrink_dcache_tree()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 11:05, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> @@ -455,7 +455,9 @@ static void dentry_unlink_inode(struct dentry * dentry)
>
>         raw_write_seqcount_begin(&dentry->d_seq);
>         __d_clear_type_and_inode(dentry);
> -       hlist_del_init(&dentry->d_alias);
> +       if (likely(!hlist_unhashed(&dentry->d_alias)))
> +               __hlist_del(&dentry->d_alias);
> +       dentry->waiters = NULL;
>         raw_write_seqcount_end(&dentry->d_seq);
>         spin_unlock(&dentry->d_lock);
>         spin_unlock(&inode->i_lock);

I have no real objections to this patch series, but I'd like this to
get a big comment here.

There's also a 'hlist_del_init(&dentry->d_alias);' in nfs/getroot.c,
and that one stays as such.

I thnk that's just because it can't actually be a real alias list at
that point, and all that case does is to remove its own inode from the
initial list to make it always be empty. And so it doesn't have any of
this 'negative live under lookup' case. But I'd like to have some
commentary about *this* particular one, because this is the subtle
one.

In particular, I have paged out the history from the last iteration of
this all, and the reason why you changed hlist_del_init() to that
'likely(!hlist_unhashed...' escapes me.

I'm sure I could look it up and remind myself, but honestly, I'd
rather have it just all explained in the code.

Please?

               Linus
