Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D63CF1EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240254; cv=pass; b=epAw0KoOu8sVGKXxAICMpvmtLyoarJ++TeCURobGe7U6uUUWf17MBkMgogNkE7A7ClX7eWtxJwTfpTdBmrz+3JtNUWVZfUCRe2WNKhJHNTWiyS2APtcQjR/5jT+E7coxgKLWHd78LkUjzqlbcXqkjoSgA6Qcouax1FaLNqIOvSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240254; c=relaxed/simple;
	bh=yCsfPmoWkWgx1jPi1tu8keGzxU7eQiy0nfPh46/1uBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaaBJwsITETkJFxz9B9TMmzqEZzSquAbJ5cMqBPPiuwyy4w63S4A3cwcawTzBArvFBCozfkZHHM/fY7N+ce+QdDIQzBF7fqUIkDwQPY4cq9BTNI/t8w1KPIT4LkAMOYh8LuSdYYzBHFl7yzKkVHKpRcLAX9okIMlB5lk351iRQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idI5Izx9; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idI5Izx9"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a985e8fcddso2487446a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 01:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790240249; cv=none;
        d=google.com; s=arc-20260327;
        b=EG3povoqCzRtr0XInUga7ZBoT0NTgJre5yL7RIZ9mDYdbRo1q6Csk74cdZk0RiAxFu
         GV52sR3L4KkbRURyd8lDBOnZei0SdY3zRRral4+T+erz5nnr8imXIPlRiwGEEvCU2Mfx
         OCs7E0ZjUJhCCbU7ocRczo1gqfjtV2Z39mBgFN9u86R0SJWujnfxR1gmIzy3+bCPbdz4
         TYtbNyqFcyZBpg05Z0DIN4GTSyU1Zi/Wx8FxjW0XYaURto4esJh2KCFbQ1dr8rKkHpoq
         F39IEzVhHaC3drftCok+hC6RDY1Xds+dMNSCrVlmVTvS9RimKtPfLMC9sPesOrSP/AJB
         rfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EdKLcmVJIQ/lTCEPBtmtKcDPQ3kMD0oCquyEuFe4XUY=;
        fh=/72b1E/KVpJk0UKw5aqcpHLgHqd7c6njbsyoqF+hWcM=;
        b=IEKnbZXhOjO1dwngTlhTGrg5IeguwZetsd05VEuCQJKc9aP3gLDDNoP/9GalZozlRU
         NtS1OvN4b7ziTTZyix0vXk6XOGwqeK5baSFg/fyiOQc2jWBKydq4geVlRRMxLdKuYgG7
         uu26QJHf74g/nvUOyj0kncJs8Q8gU+QckXTTMkGkMttOJUnOhQTplfqsYEln2rx9y9aG
         J2NRt9YKYR0fnqytrAf/+JZ6B9qD+wpz6agIfLcbgytD34Bpxv+B85bLkMLM2cQUCq5e
         +Xs709KU5LLGqMvSZd3LdYTxoUFOs7cB1iHzGfiPZOotD81t8uVTKfLcA6Lh2tAnp0AI
         fRsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790240249; x=1790845049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EdKLcmVJIQ/lTCEPBtmtKcDPQ3kMD0oCquyEuFe4XUY=;
        b=idI5Izx9K7awyrIwBdjZVa/Si3CilBKPHvDAvDrOvvaxdGM3mkswAVHkbMSJsfk+w1
         KJi5LODVjiZo+cTL46v9cPnGnp93VI9HU7uiIelfoZXqbYnvvrxfIKXB8rf8tcAbry8V
         it84RqkjfRi8LSFKuMslDM7deytZ5x5XPdIpQ9b/kiafTWhj0eIK0MDmoRd7jJoJEbd9
         +vhsDpF8sB2OM0Op6IsBDXYP9a/6FpO1cj7QYn/gEDVhSbYVElovskvRhGgj0r1KOCI9
         HlofEQS6JkUXsZAp7/TUkgJANVqU7XCwDfJRL/+WV3rSspbl5NX/xsf0QD8WKdAeBBie
         zDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240249; x=1790845049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdKLcmVJIQ/lTCEPBtmtKcDPQ3kMD0oCquyEuFe4XUY=;
        b=dhN/hw68UqAgI5c2piyUffXJEjnEna1EQNJczDEzHgK80HyW1bW8n8TaMTtmncrcsT
         Se4U34Zu4agjTed/+eHCK8D8wM3orpE2ahKRLoMddid8ept8LvnLu2rXi7KNFMStwx9h
         l0b/3CdD1rg9Rkqc2NCUegscrSX2+RmsHmnxviZ0e+L9/UTUrLr2J+1R1wrfvsSX4mMP
         T6ozgrUHfiCqtFVToZ+osiMerb9o/YKYwfA2qPMLSI4h7itii7wjeUG8Bq/kYJycELN+
         VaD2TaoXKLfUmKbFoiicGrYNRoWAwWhu1rsRKc41Qse/hxZEYXB1H8XrKAE0cYO0P8xt
         EZgA==
X-Forwarded-Encrypted: i=1; AKwUvBz50cyyhpH8/pVFb0PQ88uv8XCL1F+6RJBYNxOWMjNYfTK7jeLdNJxAUeEurYmfD4zimX/Z/OQ6MpSNvgFc@vger.kernel.org
X-Gm-Message-State: AFuF++kJXI0kvKglZZhkWdMVa+ulc9dfM86lQKJck7t7wC+CFXsAQa5b
	qiyhhI6Y6GMbpfUdHl8fP4u3Hl4KxomhDMKVJ0qbdhEyYuNEUx1EF1lFK5zenKwf2aD+r2d6VtF
	OyJs0PnZ7AVqyYYvwhApuOOouYZBkXlY=
X-Gm-Gg: AYBFou2jeBBU3oj37KPA9XTB+vYV96kRNA/6Z6FeVhOGE5CpOlcsqwutj8XckKkvjXx
	+xltBqHpmi6WL2GQiaalFw0PV3XrTJQp7hu07Ue++Wm679PcjFkYpI/Xtg1rbjIZFff1Hx2F6Rg
	SJOP+Ey71mG9E0CF/7nHPqwgx2Gt3BG4hwpxEvquFxX0ATzk5j6VUVFlmCs9RQaULckoaIvVTYT
	2GVgrRAfLT3plBaVU2lRATbHq4G2Afat4OmZQ/GcbS0AXejZgIOAdNEjJIC3AB/fZaPVrymf4l9
	d5LYeoM8DNyAxqhlwMmDfkOoqG7Yf1n7zhrxqb/jKNu95fZYY45djW5H
X-Received: by 2002:a05:6402:27d1:b0:6aa:4d8d:a0a8 with SMTP id
 4fb4d7f45d1cf-6aac90c277cmr1465204a12.27.1790240249248; Thu, 24 Sep 2026
 01:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org> <20260924-work-mount-knullfs-v1-2-ae89b29f7cb3@kernel.org>
In-Reply-To: <20260924-work-mount-knullfs-v1-2-ae89b29f7cb3@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 24 Sep 2026 10:57:17 +0200
X-Gm-Features: AclHuK_uX-5w-AepVuavFqJofaz_yQXwvhOxhkUwTXmcXOO1DNzBU4E1PYIkqfw
Message-ID: <CAOQ4uxgfDt7Ai4+r=Uct39F5hfx=vjZeH3jE9e32CeY-ybKYYQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] fsnotify: record the superblock a connector is
 accounted on
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:19=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> fsnotify keeps a count of watched objects per superblock so that the
> event hooks can be skipped on a superblock nobody watches. It computes
> the superblock from the object object it watches via
> fsnotify_object_sb().
>
> This currently works because an object's superblock doesn't change while
> a connector is attached to it. This changes form some of them. So record
> the superblock in the connector when it is created and use
> that for the accounting.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/notify/fsnotify.h             | 3 ++-
>  fs/notify/mark.c                 | 7 +++++--
>  include/linux/fsnotify_backend.h | 2 ++
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 58c7bb25e571..0be351275dad 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -54,10 +54,11 @@ static inline struct super_block *fsnotify_object_sb(=
void *obj,
>         }
>  }
>
> +/* The sb the connector is accounted on; NULL once it has been detached =
*/
>  static inline struct super_block *fsnotify_connector_sb(
>                                 struct fsnotify_mark_connector *conn)
>  {
> -       return fsnotify_object_sb(conn->obj, conn->type);
> +       return conn->sb;
>  }
>
>  static inline fsnotify_connp_t *fsnotify_sb_marks(struct super_block *sb=
)
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index b2640d836a71..1b6095fcf039 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -425,6 +425,7 @@ static void *fsnotify_detach_connector_from_object(
>         conn->type =3D FSNOTIFY_OBJ_TYPE_DETACHED;
>         if (sb)
>                 fsnotify_update_sb_watchers(sb, conn);
> +       conn->sb =3D NULL;
>
>         return inode;
>  }
> @@ -791,6 +792,8 @@ static void fsnotify_init_connector(struct fsnotify_m=
ark_connector *conn,
>         conn->prio =3D 0;
>         conn->type =3D obj_type;
>         conn->obj =3D obj;
> +       /* the object may move to another sb, the accounting doesn't */
> +       conn->sb =3D fsnotify_object_sb(obj, obj_type);
>  }
>
>  static struct fsnotify_mark_connector *
> @@ -953,8 +956,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mar=
k *mark, void *obj,
>         /* mark should be the last entry.  last is the current last entry=
 */
>         hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
>  added:
> -       if (sb)
> -               fsnotify_update_sb_watchers(sb, conn);
> +       if (conn->sb)
> +               fsnotify_update_sb_watchers(conn->sb, conn);
>         /*
>          * Since connector is attached to object using cmpxchg() we are
>          * guaranteed that connector initialization is fully visible by a=
nyone
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 618eed4d6d72..3a9ab9e0104b 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -573,6 +573,8 @@ struct fsnotify_mark_connector {
>                 /* Used listing heads to free after srcu period expires *=
/
>                 struct fsnotify_mark_connector *destroy_next;
>         };
> +       /* sb whose watched_objects account for this connector [lock] */
> +       struct super_block *sb;
>         struct hlist_head list; /* List of marks */
>  };
>

A bit of a shame to waste this space for all the inode connectors who
don't need it,
but probably not worth the effort to save it.

Would have been nicer to detach the mount connector on vacate, but again
probably too much work and not worth it.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
