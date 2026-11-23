Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456427;
	b=iLsp6YxnPYUHhmQTrljsqPLewFfzkY6iZE5pUmYI1WXkT64pkT5iqN+EACpkwkaJp/r7
	 TftQ7dl8Ab0ec/jMLJl8iwzL18L5V3ahQO6hncV6NHG1BOY3WuTeop/lrqaQ6pZnhaYab
	 niu9cN8y92hMXV3rw2R4OHrh7tR2UslZddOjQnhOafWh5MJ7BnlWX9LzoonnmVQBakCTs
	 UH1OcEs0JyB4y2bcuSSNSCKR9AN6NfF8zkm0LDeg2BqhyPGPfDi6NrHmKZ+XM8fdvnSrf
	 ByjlmFqc+laeeckFcbthOD8p2RVsK3hw94GnuiVNC9L38DSSXboIP4/e+hAsFjk62TQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RRZcWU4JooS1Xssmhmit/2z3n2umybpGN0QWpPuhuY4=;
	b=VpY4XOGLdLCpW2ufH+Fy0dfeasiHQvoCuPtZGaxYD07Efcq5uAI72fBaBjW8QvaYcDyq
	 rTNq7y4kOb6NiCUw1bRvtGklAnzcMdvlq+xSOvyGP3+pR9KACWrU0GHx1B3c/1UGXNkwL
	 GiljdpnlD1+3jDYnyUH3rwGY1WNqu2g0z/oXx9LO/t4HqT/SkFGozbS7G3Ulux5ez0wx6
	 aVTJqA7bkLqBVFgeQazITHsdskj3cyRhRQSe4+/MtPJ5SE6Wy19UnluzV5X5LfuNietRY
	 pNTgRainXkhFcnwaFUyhKSQsfSAGNUUx9GIBxF3KJVqhTxYhnBOd7oVisLCymzTOvfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kyECElfV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19FC606A32C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E19FC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kyECElfV
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb845433b8so77705e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 09:53:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795456425; cv=none;
        d=google.com; s=arc-20260327;
        b=GtB04BhakdswlhSViaK4pt79fjqVAoNoySPG7+5auT6WHWmphFwCCsZKYBLH2jdPjE
         TrRl9S0NpgcZrJjV5V2TV/DSzJrvU1g2z6vkxzTDqlKimu/nSaYzw7uTjFY7CcyAjDRM
         BMuQAlLeQDicsso94En+4C9XUvbhL9qDMB+1MsqLyuwcVIFT4qCsfHrdGsdSHzbRH7fd
         lO7P6X57RWT8TvwHEcKhima+aiCnadHvFUJ/Xf4gBwYRQ77Mvmg4v94r7lZ/gi78HI9q
         rNAtjORTqE9ovpjtrTteC1J8+6pXK7gp2CH4DmjsFjilTu2IqJyLeE9Y0ZqKXrJPalNC
         8GlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RRZcWU4JooS1Xssmhmit/2z3n2umybpGN0QWpPuhuY4=;
        fh=cypGUXIxnJaC7I0s8ic2Bt3cH9j7094DKqXocUyEXuU=;
        b=W49qKIuGxJbY2drYU2uYPjfSUeDlQQzkeviAfIlSnr3oihRJx4JdHhksLVCZfPsiI3
         ATaRNvHBnHVn1Aytc8XkONu6PjFqCOquAdeyo7jGk7X8kWnuQW5plM/pP/TjAIfsxkIf
         M1hKRB1anOZFGKUZzxopVNiI8eXJbzbA/PVcvNVeVldBqlPhWPvjYobrsePJi9Jbhp9G
         vASMTlvrR5cezqlYUSQ7X377Vf991B5X13gXcTvV9WGw/hKD+9KZ+ZxyScOt2k7Ec9mB
         8PWhT+RdYFuBp/SWxn+umzoI3Ep4cusOMJNuvWSMow2npmfOvfSUVxwkoTJ+Ue//mUyb
         1wBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795456425; x=1796061225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRZcWU4JooS1Xssmhmit/2z3n2umybpGN0QWpPuhuY4=;
        b=kyECElfVhqU/U8ppj4LZCw+7b4+EnGazFVt7ghjggT1FnikRfjNerZWMu0lyS6gb1G
         YXHvcPMLMNdkDwdmhd/wUekaBA+hVJY6zfkbb7VFKN2GAY/hYZvP44ZKuJFbBfGaJxI1
         kkfrqLNe+sutCnQM6Gy1gNbxARZ4xTO+nKXLP5CfNtBRWwMnWpWgmt0GMBU2YsE80Fuq
         CtVlS7I47Y3MIf80OYc60ycPQgR9+Il0FG8vq1sg/6rjCv/jJxaIU7I/sSafAcTJwSG7
         HLR0fExZ9V77SZiB4lJ+l9fS20ZvCbmWOgQ+rhM9CVMyBQfbX+0HcytuIrIM+/W7NDRv
         +oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456425; x=1796061225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRZcWU4JooS1Xssmhmit/2z3n2umybpGN0QWpPuhuY4=;
        b=ahXDEhdq/IsF+7Xh405mnbZtSj9GQncLcSWF1I/BV3YcrAfup38zRBafpCbPG2lT9P
         rDRRNoVataFhNXqOtLu/uix55JMaV+ySvxnVJi6O+Jt1NEFChg7N6X+FoKvsPXX6YkXL
         0CbEzltx/NnM6w+vjDrwdMwYVGYs0sd8xruct/GnxtkGHKaz0r3rLX8OuZeMCzlCLO6t
         vZHFWvIkotwD7cdRPP/nT2ZZ5p0psrmY7VkGJYrAcLz/sUInxogjT/TkDjv0bMCbG/iu
         MbQP1Upvfax52avwtTeJYJV/kWVF5wyGqif70YPxIcFndzim1oQTa/qwLmn8NQFKdAsa
         PTKA==
X-Gm-Message-State: APuU4Z81rz3U4K1E1FNam/OG3Tlon6ilBwL/njxQBmt0EcF3GWqC8Qmh
	1zC5ZmmMnUygS73u1yaRj0FjmfvV7aedISZZAp9zRmkqD5SNnJFCQyHNhNoxAgCL2TVfInNDh2k
	8bROPwlGWm0AY4ddu7bNoYxW4GvWB2QKEp7D1gNki
X-Gm-Gg: AZFdTZfvTvPC4jseTHqL86C7fqbP2AreiJcG3NWgJjd4JGIpiFl7Zhg3KE9ix0QN9QE
	SPL5xcQ95672GBEGNKpfRDKN9KENMNdezRQ8Z5NN92Y0S9AXlvukEcFEr+a/rzlUGYQgJbfQX7I
	S8CvXuJoJC9nx4TznoznLQHHhwyzhkN1wYEx6nBvrYg+JuXL+DUOoBefE8JpGwEdrqfSKRUetlW
	UCbTmI6ZSFeGm2rHG1RsQxYm2O1nUdQYjvcR5M28xCKbM8mtd5VPjICw6hVKYIPe7CEvLWHjVTU
	UrbXhcRoW1lBZEzNphbOC0v+PHNbK+Sahh1lB519pBHQMo9HtuMoHt/fRy3fB3SvhTQNxe8AHTL
	uByBhNeF2ozZOiIBVt8WYolD+Qwcb0xE3UXItf/hX+RppFNQIg/CkDIHM0wLIGjPn0otUSSR9uH
	Wg5m+Z/ZZNQEPwUgtL6FMaqd6T
X-Received: by 2002:a05:600d:6512:10b0:4bb:7ae3:3517 with SMTP id
 5b1f17b1804b1-4bb90bc3163mr1231475e9.4.1795456424900; Mon, 23 Nov 2026
 09:53:44 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-work-kernfs-delete_self-v1-1-514a35d04431@kernel.org>
In-Reply-To: <20261120-work-kernfs-delete_self-v1-1-514a35d04431@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 23 Nov 2026 09:53:32 -0800
X-Gm-Features: Aa3M54ob7XYovyBMvNusAZSyIh_lIUnU-OICma0eFsVui65MkMhLZKbHyrFxGng
Message-ID: <CABdmKX0gJbjX89B7Cxerh7AUjP+dJSOm09TmY+Q_AYTge5Ukww@mail.gmail.com>
Subject: Re: [PATCH] kernfs: clear i_nlink before deactivating removed nodes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, driver-core@lists.linux.dev, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Ian Kent <raven@themaw.net>, Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 1:00=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> __kernfs_remove() deactivates the whole subtree first and only clears
> i_nlink on a node's inodes later, once it unlinks the node from its
> parent. In between kernfs_dop_revalidate() already fails for the node,
> so a lookup that runs into one of its cached dentries kills the dentry
> while i_nlink is still 1. For a file of a cgroup that is being removed:
>
>   rmdir("cg")                          stat("cg/cgroup.events")
>   css_clear_dir()
>     __kernfs_remove(cgroup.events)
>       deactivate the node
>                                        kernfs_dop_revalidate() =3D=3D 0
>                                        d_invalidate()
>                                        dput()
>                                          dentry_unlink_inode()
>                                            i_nlink =3D=3D 1, no IN_DELETE=
_SELF
>       kernfs_unlink_sibling()
>       kernfs_clear_inode_nlink()
>         i_nlink =3D=3D 0, but the inode has no dentry left
>
> The inotify watch keeps the inode alive, so nothing ever sends
> IN_DELETE_SELF for it and the watch only goes away once the watcher
> closes the inotify fd.
>
> The window covers everything between the two loops in
> __kernfs_remove(). kernfs_drain() drops kernfs_rwsem and waits for the
> active references and open files of the node, and the clear itself
> waits for kernfs_iattr_rwsem behind every concurrent permission check
> and stat(). In a VM with a few threads stat()ing a cgroup and one of
> its files while the cgroup is removed, IN_DELETE_SELF for the watched
> file got lost in 16 to 33 out of 150 rmdirs, and it didn't show up even
> after dropping the dcache.
>
> So clear i_nlink in the loop that marks the subtree as being removed,
> before a node turns inactive. kernfs_rwsem is held for writing there, so
> no new inode can show up for these nodes while the loop runs, and once
> a node is inactive kernfs_get_inode_locked() refuses to attach one. Two
> overlapping removals may clear the same inode twice, which is fine.
>
> Fixes: eea5d2bb34ba ("kernfs: Send IN_DELETE_SELF and IN_IGNORED")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
