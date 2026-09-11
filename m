Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588894AEBD3
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154604; cv=pass; b=hMJ8A+XHCvZ/fA9cpDjCiRewBP2P/KDgAy//W1ha0E0TFa3Ygu0pmJ4KwrCiHOdEnRqpSSRtF3WEtYPlJrzhqmPNm+JAaJ0pgYtaPrQJE0a3F0y12n6FvbtjLGy9qdDDOHCIp7hnsXK5WSmUs9ad0Xh6sPxi75E0d+Qkonjn5cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154604; c=relaxed/simple;
	bh=62zlUVJSESl0HyWfkZ7/G3I1CiFlk4lNjkUBrylBGVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWS8hdpbyzo67b9wrdtWi0aoscftNhCJ/plFP8J1o5IeOPWxoCzBz0rz8ehL2T7hCYlYaTssQmu2vEhf+6m1ybzusv9nXcRDsKtVLOKN/fw5izkJwtLLP1j8nD2GfmmYjMg2v4wORgEzKQf6uv0tqShKTrt/phTO9U5nPo6gDpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aehBUrF+; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aehBUrF+"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7855bfd6ab6so434785137.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789154596; cv=none;
        d=google.com; s=arc-20260327;
        b=dEhRwTRECt2hYbaIr/SKQXBIziSP2+ZPRYaEvkwEP8hiqnAPnKg0rLO8aG7ZX/SKEe
         kYtqqTbH5r2Sm/KJnAcy7VIkvA4u5+/7QPyn7g/552QfIjrAzoOgr60WD0JssrGF9OBS
         4RwA2fdan3l7aYLWlt++djAxOA2lSQ+Vpe/ibq7RiGh2lJeMqJe30PfIjmEJgaz8mEAF
         kzXqJjrYvP3znPshJz8WThvksWNwlNlHUTAVwDnxsj8e/wS+Uzi0+WdabK53xMcxh8/B
         0Gxercsq09l2B+Jr7fxLOGnuRRpp30KnsxberXFOMCf/pxotXDmTCzTSstDsGyYvDWRu
         vZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PhVX3j9HCCkbLuuqmLLwRW8XFC61fFVfA+SMOFYe1wg=;
        fh=zOuv4f4vufFlFrr37AsS3WN8+NmO1HnT3zkzAdYt07A=;
        b=id+QAj/0xR3vEPVCTmSmxOfGb1h7yku2sgxoAlPuEDOgAgCMMmLLmgYBf1WlCLW6eC
         4dCcykBw2/aMiq7ifiQjDRmlK7cu2pCjQ8eA96KkS9ZqHZ3UIBsDGuiLA2aw60lskyDa
         LJHQhPYUlsG3RPTacgIxoL6mLLbvSWjzaBRdM6iVtQksntEShhckSh6b2BXAWaV+AnnA
         5SEdhurlq7Z4FY3dagcwLbC1it3Ov26+rDdrQjhDjs7cnVJ7nIzJbWcBTRIjC3/5OKqM
         GdPRXZIkXHnEwMpDK3/ApmEenpuBFXa7l43GCKdGcm0BoncbAOCwQ+rs4Fx1uWmY5Lf4
         2XDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789154596; x=1789759396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PhVX3j9HCCkbLuuqmLLwRW8XFC61fFVfA+SMOFYe1wg=;
        b=aehBUrF+85+UFrvpUkbaQfbPQNUKJJhvShhqZFCcLmisLbAYfx8gUoDCkP31AK48iK
         5sRc0lab8QQzj52+X5MP5lXSFHqeUrdZcieJpS1VkTUuQGKDUzrethVkOFzCXjXw9hq+
         51PyElsRReTEAPwuxut23bXE9Ciz+Ml2pmNw0+RbjL62njcWGqo04NnakXdTBwWbok5Y
         OWQcncgWDkxVSVYh/vklL6RWfybkgTh1w+jns8I+Y51Rv+QFaLXDp0FeaCJBke0+oWbB
         W2Wpr38EfEgqa+qGp00gBn4snDa+c4hBzYp7HHESFMFkQKO3jUqruQ13Eu60Cettftvw
         Ip3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154596; x=1789759396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PhVX3j9HCCkbLuuqmLLwRW8XFC61fFVfA+SMOFYe1wg=;
        b=OS4NPXLpswMUqafam8h2Q4K/Amakt/VvWEmlyFf05Ku5+asgZmsnwrV3I1AsqaqYq+
         EXCYVMzNxNdxPTmVYg9pXb36+1/NKU0DFMc5ur7IorL5Sb2RrkSy4I3Pjz8t69Cfs7Wg
         93Tw781uqn3OhvO0hnVStlRQRgv/LWE4DJVp39rkORYOyOC2CHW14bCqqHq0dCCJs66O
         A+6NE0eHqQuaIpV+Urq+XiSjf/BaEgfrn9YkCcNus30tUKd7AIZTZk4CKkEOeeFLCQqw
         E/LiEXR650cSO+ecencKZgmL2N9brPiWeGYf+j25rpEL8m+NplSWQoRymR3PK70KM0/w
         JaWA==
X-Forwarded-Encrypted: i=1; AKwUvBz52+CatXyTiZ46IEaaGOzop6c3VGjSfPc2hH5VY7wefU+jekYG5szvI2BtEFS0yB405f5L4TxdhDDQxy8F@vger.kernel.org
X-Gm-Message-State: AFuF++kd4zj5epySeBKLfE/vrjhHPz9St796YEQ1gGtYY46op1YMMB/X
	OKH15aQPKrzAmdTWBdghni/l0N2kDJKD0aDMyCY/TeM51ZwI3eUeVoloeZg+Lk5LwAiRU2EDyeZ
	yIAuxPrnel7aANvxin9qwQGhtIH5mhali0E5J6CM=
X-Gm-Gg: AYBFou0ecvo6V3FkL3ntOWoQXxvAaGRTIgCfyFrp5mpNEXthUcqXjQlA/geiUaRFSwB
	rHGK9fxaeFWeimXdP0CBqdCwo4DoFnN1o8uLOlspH2WChyhh8Bwv/rQbLZYGNqmcyALSJDW3xcf
	Lk6dyixjWes/wsdibMABmGcTPcCqSAGQszLSrjWW/9TUyQj77PxsIGSPa211aUqU+85ABfQ0r9e
	Dl117bdn7bEtRECTMxYzqEomUt35uAjNsFjfKZGSVAtenCZOPKbof3hzay9gji60EzRRDb4f9qN
	cSfZRUzvy8wtVdMGtsFgpyq0N9/L/lCAReTkp2SqOJYwa2bbV0QHliasyNDeYPloHzQ85f7ouuN
	mAzLhO7wCStaZd5KP2BU4
X-Received: by 2002:a05:6102:41a2:b0:792:2a1e:f9bc with SMTP id
 ada2fe7eead31-792a69532e6mr7921413137.6.1789154595208; Fri, 11 Sep 2026
 12:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner> <20260911-suggerieren-suchaktion-fliehen-87b9cdf1d169@brauner>
In-Reply-To: <20260911-suggerieren-suchaktion-fliehen-87b9cdf1d169@brauner>
From: Bill Wendling <morbo@google.com>
Date: Fri, 11 Sep 2026 12:22:57 -0700
X-Gm-Features: AcwNN1U2UiftgU0O-MISENhtsAPDQT8m10Lr2mdv2yJrv7E3NkvZENDE4lT5Wgk
Message-ID: <CAGG=3QVc0yQ9Cjk5fPzqyqXDzPiWzGO2di2EG0Vwh-TRjtvnkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] userns: rename insert_extent() and sort_idmaps()
To: Christian Brauner <brauner@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	kernel test robot <lkp@intel.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:59=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> The KUnit test suite turned insert_extent() and sort_idmaps() into global
> symbols and declared them in include/linux/user_namespace.h. That header
> is pulled in nearly everywhere through linux/cgroup.h and the btrfs
> self-tests carry a static insert_extent() of their own, so any config
> with both test suites enabled fails to build:
>
>   fs/btrfs/tests/inode-tests.c:16:13: error: conflicting types for 'inser=
t_extent'
>   include/linux/user_namespace.h:212:12: note: previous declaration of 'i=
nsert_extent'
>
> A global symbol needs a prefix. Rename them to
> uid_gid_map_insert_extent() and uid_gid_map_sort(). It's the better name
> anyway.
>
> No functional changes.
>
> Fixes: f6f1a2496ba5 ("userns: Add KUnit test suite for uid_gid_map")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609110843.okbPe7GM-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202609110937.zHKPPXJk-lkp@i=
ntel.com/
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Apologies for this. This version of the KUnit testing is susceptible
to exposting duplicate symbols. :-(

Reviewed-by: Bill Wendling <morbo@google.com>

-bw

> ---
>  include/linux/user_namespace.h   |  5 +++--
>  kernel/tests/user_ns_map_kunit.c |  6 +++---
>  kernel/user_namespace.c          | 19 ++++++++++---------
>  3 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespac=
e.h
> index 633157781edc..637cd7e91a45 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -209,8 +209,9 @@ extern bool current_in_userns(const struct user_names=
pace *target_ns);
>  struct ns_common *ns_get_owner(struct ns_common *ns);
>
>  #if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
> -extern int insert_extent(struct uid_gid_map *map, struct uid_gid_extent =
*extent);
> -extern int sort_idmaps(struct uid_gid_map *map);
> +extern int uid_gid_map_insert_extent(struct uid_gid_map *map,
> +                                    struct uid_gid_extent *extent);
> +extern int uid_gid_map_sort(struct uid_gid_map *map);
>  #endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
>
>  #else
> diff --git a/kernel/tests/user_ns_map_kunit.c b/kernel/tests/user_ns_map_=
kunit.c
> index 24c21e43a36c..033dccc6a535 100644
> --- a/kernel/tests/user_ns_map_kunit.c
> +++ b/kernel/tests/user_ns_map_kunit.c
> @@ -24,7 +24,7 @@ static void user_ns_map_insert(struct kunit *test)
>                 extent.lower_first =3D i * 100;
>                 extent.count =3D 5;
>
> -               ret =3D insert_extent(&map, &extent);
> +               ret =3D uid_gid_map_insert_extent(&map, &extent);
>                 KUNIT_ASSERT_EQ(test, ret, 0);
>         }
>
> @@ -54,14 +54,14 @@ static void user_ns_map_insert_extended(struct kunit =
*test)
>                 extent.lower_first =3D value * 100;
>                 extent.count =3D 5;
>
> -               ret =3D insert_extent(&map, &extent);
> +               ret =3D uid_gid_map_insert_extent(&map, &extent);
>                 KUNIT_ASSERT_EQ(test, ret, 0);
>         }
>
>         KUNIT_EXPECT_EQ(test, map.nr_extents, NR_EXTENTS);
>
>         /* Now sort the map to set up reverse mapping */
> -       ret =3D sort_idmaps(&map);
> +       ret =3D uid_gid_map_sort(&map);
>         KUNIT_ASSERT_EQ(test, ret, 0);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
>
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index f9cbb4b92b48..98b0279b6cc6 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -780,12 +780,13 @@ static bool mappings_overlap(struct uid_gid_map *ne=
w_map,
>  }
>
>  /*
> - * insert_extent - Safely insert a new idmap extent into struct uid_gid_=
map.
> + * uid_gid_map_insert_extent - Safely insert a new idmap extent into
> + * struct uid_gid_map.
>   * Takes care to allocate a 4K block of memory if the number of mappings=
 exceeds
>   * UID_GID_MAP_MAX_BASE_EXTENTS.
>   */
> -VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map *map,
> -                                  struct uid_gid_extent *extent)
> +VISIBLE_IF_KUNIT int uid_gid_map_insert_extent(struct uid_gid_map *map,
> +                                              struct uid_gid_extent *ext=
ent)
>  {
>         struct uid_gid_extent *dest;
>
> @@ -821,7 +822,7 @@ VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map=
 *map,
>         *dest =3D *extent;
>         return 0;
>  }
> -EXPORT_SYMBOL_IF_KUNIT(insert_extent);
> +EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_insert_extent);
>
>  /* cmp function to sort() forward mappings */
>  static int cmp_extents_forward(const void *a, const void *b)
> @@ -854,10 +855,10 @@ static int cmp_extents_reverse(const void *a, const=
 void *b)
>  }
>
>  /*
> - * sort_idmaps - Sorts an array of idmap entries.
> + * uid_gid_map_sort - Sorts an array of idmap entries.
>   * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE=
_EXTENTS.
>   */
> -VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *map)
> +VISIBLE_IF_KUNIT int uid_gid_map_sort(struct uid_gid_map *map)
>  {
>         if (map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
>                 return 0;
> @@ -878,7 +879,7 @@ VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *=
map)
>
>         return 0;
>  }
> -EXPORT_SYMBOL_IF_KUNIT(sort_idmaps);
> +EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
>
>  /**
>   * verify_root_map() - check the uid 0 mapping
> @@ -1047,7 +1048,7 @@ static ssize_t map_write(struct file *file, const c=
har __user *buf,
>                     (next_line !=3D NULL))
>                         goto out;
>
> -               ret =3D insert_extent(&new_map, &extent);
> +               ret =3D uid_gid_map_insert_extent(&new_map, &extent);
>                 if (ret < 0)
>                         goto out;
>                 ret =3D -EINVAL;
> @@ -1091,7 +1092,7 @@ static ssize_t map_write(struct file *file, const c=
har __user *buf,
>          * If we want to use binary search for lookup, this clones the ex=
tent
>          * array and sorts both copies.
>          */
> -       ret =3D sort_idmaps(&new_map);
> +       ret =3D uid_gid_map_sort(&new_map);
>         if (ret < 0)
>                 goto out;
>
> --
> 2.53.0
>
