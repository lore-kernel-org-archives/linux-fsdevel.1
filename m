Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1F3B3BEB
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567758; cv=pass; b=Tew2eolY0syPpvvAqJhG30OAVrLlwSyPrTz85AklA6IG1S7IhOcwVXP8uTso+hvmsG43LcmiYigZzQP+5B1+iJ6wg03UphuN6RBFUu/2k/9dN5g0Z36yAxI1UiC9UU7jhrdSWF2Mq30v3kJBuZQGRtBq8eaRANwRbL8Dz3ZzotM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567758; c=relaxed/simple;
	bh=6i565q7fXcLPFqrgBH3U/h1+sCz5KxVk4IbzWVMk0sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O57OQolkNZAmKt40k/ZG7HUjrmgMFu+cPdrD0eI1svnbRralM4FSQXdsUhTAR3Sr1QQRGVzV5AiYrX3FzviW1KgVv2To4I7zggtbOif8ynfAorQ1vCnDk0VuSYbFRUq4V6a0m0BkL0IT0qdKHUT58bFwFLovVv/4lJNO7mi3KX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKfDEav6; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKfDEav6"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506aa685d62so8607401cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774567755; cv=none;
        d=google.com; s=arc-20240605;
        b=kqcHFBJ1Tw24oryrjfgsBdvnnX1cWkPObslmzZ+TfBvtzOPUruxo0beMWm8p28nznw
         5aEJvmKIDzXJOJ67cdauFC6xl9VS26ygJbP9RvUhrB9cQ8ZSftOXBHqeMX7rRSGO1Fna
         ABaSr7hCs5/B55Y+vbAc6qWJOozMlH3nLdO7fVd5wNQHvB34t3kUVwNxs/R9dUTTTpdM
         SOvEasiekck9Vg0po7GmGaGAfC4+gYopwfOKbYMSAj3orSoRytZu/2Yuvptisw2VUY0s
         +NbZruFLZMkn4fbFx8GewmyKAnLoeb64fYr38o9cxFK4kfNhnXbYiMAz3Uth5ALNvFRd
         tvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZnXFVtU3N44+e5AvWSRM23w7ZT7/1s6IxCyauSmpLW0=;
        fh=IZQTVCkiQs9bOeXUkuPDrJ9t27jFUi5FVHUNvftfmqQ=;
        b=iAlYHiKn9ZO8w1NjkMLEG+3LkSvABrI9EGgRh7Pw9tcFUaudjxL7tIVgCTo51YOYEd
         xDUveyjVnj5RiDO/x0bRID1r6lkUBmx662ui6sWHL13S8JVj40Jnm/j4DKstxoNvriCB
         98mWgaNlN1snIysdOOalmHBOARqaG+aXu0Dh43wl4h37xzSeywGfRXd1QVvUnyBMwb2n
         MmpVtncP25QGTBBwQu+L9ebbEMrgyWbyxMe+uWAmAY2H+Hlj2fEwS/AVrYsQ++dr+w85
         19NU/6+wFZwJReFeerqXzuQXUxhaxhfFJ/LpJgTuDQvRQLVMvu0x4dajmJ1m0vk6pQoo
         zOSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774567755; x=1775172555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnXFVtU3N44+e5AvWSRM23w7ZT7/1s6IxCyauSmpLW0=;
        b=YKfDEav6V8i4Z48ETXE+7iYuK6O1P6tZp1M0YxT4TikfQ9l+rMBt/AGfd66TF3YiCA
         VfaALgUs/iqJmUKV8umk8E4pKgFEjJLBqyC4/ZHWYinv28ksooMJ2VxSSoZ92In7omhQ
         Ps5hvD2Yy6JLVwf9T+39/lTrF70jvuzuFA1RWzt2cU79apD8+SLbbAtLlLQT1e+yMFJP
         hkR9yr3nrEsocYmEQdOqRDino6JA6A2gAwQsEqQQHbbbYXSvmDDNcAn4mcYHX6NYnpdI
         MayQroCDaZGqaCgS/a+miE/TePnqY1clsqqwF+uXUzA0gf7IDSxbgSaT+vh5dgoZuf3E
         XRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774567755; x=1775172555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnXFVtU3N44+e5AvWSRM23w7ZT7/1s6IxCyauSmpLW0=;
        b=iuqUVmIUL4+foJuJyO31iTxd5rzQLjdzDAnh6ZCO9Ggr59UHEJS62+xlfd4RqOJbwy
         cxRhjF7NZOcMljf5bN3WKNzl9Jvnj6Z7/J4btOYXBagoMncA/eGD91tQvt7RT0REA/1t
         pZ6rRYpT74Ha0xgRZDLbjXhaY35kslJ8AJqYG/PJ9v2iutV9ZpwrlKsE8/6BR7Y9HvlT
         d/MfiDEe9aCfupg8OT3GlhIX8n1P0Co5ceSUn8d1SZ3UepM4rDp0UE5AgduRmZXR8bxw
         2MRoNT4ndo1USli7JRUbRQJan/Ze/Zwjyf/KN+FTtuinmPsQk+2Cu4+cfL6mXJVLdYxR
         /qzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHjb29zqXmPjlZ2pOX3MYN+p/ni902Iqn/meGHWSOYtH7JmfDgaRvRw6QPgvahK8xB65BqEPcnFSuSoTAc@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbiixJQ4jzMOd+TwiUQH8UL4nHrEcZnksckYp9O/Aos8x4MkZ
	4cI4FAczyFwXBEOE1vHFJajX5MFNA94PyjD94ZG9b4NnaUYegrhItqlF/kAu7k4Rw1jVyvU3Ey5
	i0b6D1nEmjaf74poobga2JZJzC37iPIw=
X-Gm-Gg: ATEYQzxWU2nSEFDJ/9btZ3yTRGGC3FJixAABPnU92x6F+ixVnjbHhcNjaLl0D2HWHrS
	n2AvydcHU+xmgGJD94MTNcQ7R4uDXnBFyQG4eDXOKIKr6HSEwGK7YKwlfq82Gewce55k2OYXEI2
	6UEYIGj8CKux3Uo1DxrPJaq9mTezNNFvzkbrsfIPjPsJpbGyaKEGAJ+Fqx2BgQhPRROY0U/xyxr
	MP0dbk76bRFwTPj8pxxe83LCvys3q7fS1JljvgXl1wBC47rLDl3+mUTSAavHafGMXfsqY12/1Nd
	ay0Y29YyA6jHx+pWEs5h1Rl+JPSW1zjiFedsa2g=
X-Received: by 2002:ac8:7d08:0:b0:509:3025:ff59 with SMTP id
 d75a77b69052e-50ba38447bcmr7756111cf.20.1774567754913; Thu, 26 Mar 2026
 16:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326232130.1891210-1-turyshen@gmail.com>
In-Reply-To: <20260326232130.1891210-1-turyshen@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 27 Mar 2026 00:29:01 +0100
X-Gm-Features: AQROBzDjx8ezXRoMyEZJsWkooKKULxiZKFTIJJlCbNY1L0YjZRhgjo4u7aVRZRs
Message-ID: <CAGudoHEHua4cA2-jZ0Yf54LQtuG_7=We-EMcW-yriNQ5JZzM5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: fix deadlock in insert_inode_locked() waiting for
 inode eviction
To: Xiang Shen <turyshen@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 12:21=E2=80=AFAM Xiang Shen <turyshen@gmail.com> wr=
ote:
>
> Commit 88ec797c4680 ("fs: make insert_inode_locked() wait for inode
> destruction") changed insert_inode_locked() to sleep via
> __wait_on_freeing_inode() when it encounters an inode being freed.  This
> introduces a deadlock when the caller already holds resources that the
> eviction path needs.
>
> For example, ext4_new_inode() holds an active jbd2 journal handle when
> it calls insert_inode_locked().  If a stale inode with the same ino is
> being freed, the function now sleeps waiting for eviction to complete.
> However, ext4_evict_inode() needs to start a new journal transaction via
> ext4_journal_start(), which may block in add_transaction_credits()
> waiting for the current transaction to commit.  That transaction cannot
> commit because the caller's handle (in ext4_new_inode) is still active,
> resulting in a deadlock:
>
>   Thread A (ext4_new_inode)         Thread B (evicting old inode)
>   -------------------------         ----------------------------
>   jbd2_journal_start() -> handle
>   insert_inode_locked()
>     finds old inode I_FREEING
>     __wait_on_freeing_inode()
>       schedule() [waits for B]      ext4_evict_inode()
>                                       ext4_journal_start()
>                                         add_transaction_credits()
>                                           [waits for T to commit]
>                                           [T blocked by A's handle]
>
> Fix this by replacing the blocking __wait_on_freeing_inode() call with a
> non-blocking drop-and-retry loop.  When a freeing inode is encountered,
> drop both i_lock and inode_hash_lock, yield the CPU with cond_resched(),
> and restart the outer while(1) loop via continue.
>

Please see the ext4 fix:
https://lore.kernel.org/linux-ext4/20260320090428.24899-2-jack@suse.cz/
