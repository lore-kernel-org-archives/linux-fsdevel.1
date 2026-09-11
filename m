Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0294078E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154661; cv=pass; b=rUHj3hMLTiyMrwS+T8octZbP3QY1401XpQszvgy/Nz1LVFrUOdM34ObsaDhz1YFqzeNMRbS/oFyI4BKEmRFsbK8M+XFj7UoTq3MGtuK6ECqJ5R86FjbWeMyEul1a+l8xiQBYgkHhpKetnz2CFhghQ92cSCZAl7CpaXkyMs3mQZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154661; c=relaxed/simple;
	bh=Fdw+r3dysTF3WjqXT9axUm7jMijJrnIOkKcC5AZjbbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK+mX+mTgxyjluazsURY0oH7o5pq+J46lCjxGXT6vYGdT1bgRBGyAY/p60IKHVgavuyj2ST4GJoLz9Vw2qs2jyAHNC9C5Wz+QLAW43fTEPwRTWIqO5ouXwUpiLkIn/85v5K/Iw8plXOg3ERUyydvKXNFDB5sZqizHI5QNVwd3yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0dNBhsS; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0dNBhsS"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-791b0163eb3so882872137.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789154651; cv=none;
        d=google.com; s=arc-20260327;
        b=NW84xclvkeqHFP02x1A9ozdlerT3iv9FIsdlmWnqltIVrc5WsN0Xk9qSavVy08A8Wk
         Tr46UN+WQZwAx4edXoqm8Uf+Wa0dou2MhGYMVpj3fg/4PpyQcv6t766mZmZcL4nkiNrO
         c2ksgQar7tNYcPal4KzYuOORmhKkoaok0mVITFu5gTCXE/LSdMMMUheQeqhqaV6otp8X
         e5RQ8unHwAF0OL6jYITq05ls3QOuX9ZrJN5xyI1zx8Qj13BhbdnqeLxv0CUJzS89DVAW
         e2eLTZE8AHK8N9Rn7AXe7VwoPyZuLhrp3jJrwjEoUjv9SAuM2U0/6qI66vWce7Gc/V22
         aUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D9lUlaXsCvPiCPFMAfPhKXQQhy684K2H2SGMPGJQm6U=;
        fh=GDXCioAgWax2oQHoW+FGYDMpnCmL/jiix2+y26CE3MM=;
        b=cnTBFQNzO1aROrSoQeMc5JByanG79ieaCAXQ2IQbamJLm/MtXmL1DmNWUa98HB2D8G
         43V42glmVVx8+EV6VSuMsjjPyNSIqp/d5b/ygC9FZylE9pmgDfgKgTn02HsURKsrWkla
         Mu1xhKq4imooOEepVUvAM9U18AVUJUQsm5pT3k6wO5tf76aAMw+sRaaWjOeZLkuyj+GS
         JCNxoRhYeL6yDs4JHM75GeDTvKilv8HP8wLss5tsl0iQPrkoH1F/PDEuGunUG4fNf/Ju
         2zRMhgy4lJkoeNFj98oFoh5NtOy+FjuVJYiAOnMhIPnpvOuDslh7SiuFTPfiztv+xzra
         7e9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789154651; x=1789759451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D9lUlaXsCvPiCPFMAfPhKXQQhy684K2H2SGMPGJQm6U=;
        b=t0dNBhsSX2AQI9wDHg2vq5fkSryk7Mjx1vpHl4tYrx152QTNTv9KybJwEUTZ+gM6eg
         fbGGh0XoNpFPX2NAw3GAklacgT97Kir5k8Leq+0/tch+y9eptRGGaqAe4QaHKPFdGpdg
         qqFvbVX0s9J3tMcC1BoxWl/dS0mmvSqdLMzo99hJgf57mSWokmqVnxeW+MTPMo8+qqNm
         wOH7NKNJ0wTrKc+n9Kb1S55WY7SI/99AkLAGJCPzC2YdiSod0KVONWhgxOZeByYbc516
         f+GTqcZoc0BIUzpuGu5xlgU5k/B2yrTkIHxaV3rIRBUPvTw/reAVQG3VzcRIuPVpJH8n
         MEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154651; x=1789759451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D9lUlaXsCvPiCPFMAfPhKXQQhy684K2H2SGMPGJQm6U=;
        b=X9LIcRDB5kCuot6bQZAyNuTwPhHQ6dS8rI7sOeEHmcIFfNdFmrJ2hqf5pIbwOWl+xF
         cYosrA2crtysMPs9gYtu0goWdozgTtw3kQq5Q3syHPSP0V3YjxriE1ZlXo3yIPYqiTXd
         b5UsvFqRNcojXqwG94gRnRcEb3iMRBsLUAY+lc7E0QZiDtAEXp6h9lQcmH038vX4mOgp
         vvgOru2FF3Bvd6m37z7dG3B6Ksu6ZM2qgsqCBUdsFXFdtmGvjWhy1Y0cIm3q2SjTUMIR
         YkZNLegGuyLeiYzEC7URxSP1ntjTkC3CznVt/dU1OcfndrQqDbY4sONi1n6fMZItxO4D
         bpEA==
X-Forwarded-Encrypted: i=1; AKwUvBwFua4kuGU7kvcoxHNYaPkKrevo8uf6wkRMhE87CV1oPHGSyPQKWCFPf9tL/NTJAovVbc9claElSTCuBgcS@vger.kernel.org
X-Gm-Message-State: AFuF++loy8Mo5g3xMel8G3Bbt2jZJzDERCL/IpbtHdiXh8+0iVTaAZmu
	C4Nqf4yrhQMfzZbmFGYEz3h7wqyhaBClMnw2wsUjMZDRtGYq8NylNOXmdGZ7MfarC+6IRd3hPao
	cTpVcTzFYmAVlXC9zYAkyuOZghLCC78z8P2iKt8o=
X-Gm-Gg: AYBFou0qmZN0o54Jum5IW/m0J0K9oo5NHCEm0Y7lT/72OsotNsbvlcmqV2kYp+7cvpr
	ZRX56O6vOzFff/HddHVDeWyr0MrCKZCGGAvsbuTr32z6uNBKyIAa9oeZB0p8PgJXq5daFM1hLYs
	js1mGkJr22yIrVcFBDKCUzId7+nlWU/TA3a10//LkIjs3DWOzBQvpj8XhFH4nmECveXB0ZSyJ2Z
	ijXYsHdEU4dWf58oJY9Sk1LDco4q70X5w9f/BIUmmgJO6xto5bUZzllwnatsan7NU99Z3TOJ0kb
	WSE0fGqEGUqOfyXzAoqR8/Oo0XANuH75qh5OY6KjdklSV87hCIoCUA1f/opfKfTfpNVK3yQQLhG
	Psyfle798uc7d+oGkOxfM
X-Received: by 2002:a05:6102:55d3:b0:785:eb33:87aa with SMTP id
 ada2fe7eead31-792a7c0cf6dmr6291546137.5.1789154650910; Fri, 11 Sep 2026
 12:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner> <20260911-zyklisch-stuhl-zweit-d61b18a17838@brauner>
In-Reply-To: <20260911-zyklisch-stuhl-zweit-d61b18a17838@brauner>
From: Bill Wendling <morbo@google.com>
Date: Fri, 11 Sep 2026 12:23:54 -0700
X-Gm-Features: AcwNN1XCuxA56YE74BOrs6AnS18Rv8BxhySba1P_h50I4QrnUiuUdff7p6DrTHg
Message-ID: <CAGG=3QUiRinW3B+-zOd2sPdHbu9=Kt+QdE0mQHcK4t06qC6ckA@mail.gmail.com>
Subject: Re: [PATCH 2/2] userns: declare the KUnit-visible helpers whenever
 KUnit is enabled
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
> VISIBLE_IF_KUNIT drops the static qualifier whenever CONFIG_KUNIT is
> enabled but the prototypes for the two helpers it exposes are only
> declared when CONFIG_USER_NS_MAP_KUNIT_TEST is set.
>
>   kernel/user_namespace.c:787:22: warning: no previous prototype for 'ins=
ert_extent' [-Wmissing-prototypes]
>   kernel/user_namespace.c:860:22: warning: no previous prototype for 'sor=
t_idmaps' [-Wmissing-prototypes]
>
> Guard the declarations on CONFIG_KUNIT so they match the definitions.
>
> Fixes: f6f1a2496ba5 ("userns: Add KUnit test suite for uid_gid_map")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609111048.yhHILE11-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202609111305.ta3EOA2x-lkp@i=
ntel.com/
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Feel free to add:

Reviewed-by: Bill Wendling <morbo@google.com>

-bw

> ---
>  include/linux/user_namespace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespac=
e.h
> index 637cd7e91a45..91232053775d 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -208,11 +208,11 @@ extern bool in_userns(const struct user_namespace *=
ancestor,
>  extern bool current_in_userns(const struct user_namespace *target_ns);
>  struct ns_common *ns_get_owner(struct ns_common *ns);
>
> -#if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
> +#if IS_ENABLED(CONFIG_KUNIT)
>  extern int uid_gid_map_insert_extent(struct uid_gid_map *map,
>                                      struct uid_gid_extent *extent);
>  extern int uid_gid_map_sort(struct uid_gid_map *map);
> -#endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
> +#endif /* CONFIG_KUNIT */
>
>  #else
>
> --
> 2.53.0
>
