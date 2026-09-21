Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2022937F32B
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018463; cv=pass; b=lsLNgbqZlkvK+wZq9JkKrw2nPrp/tRugYmoLBw0fpyxOO9zKGtN6/nQqb5Nc83J28XdVZPfsti/aqQctY9k3W+F85yPyKIRGoLaSVmlFXSMUkOQeLWPT/y8ijwj7w29mNJ3ylW82vPg3vHheGqvV9JvXpm8vyU4oIZGOk6dnKus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018463; c=relaxed/simple;
	bh=qlFdAR0F/wCuIts0PKz0zOO+oD2tVvhCexRQzujbsd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcTgYFT4LYXf6OE4PELalCVsXhXzr3zWv/bSZ5G0sXn8KrXosUUmb+rsAWo0ZnAXNqrQPkTjv0kbw7qMUzNfriWbVHlHE22qTV2unp33bhO0ggLNzaE47v+dkd3/R5/TlR8rQJGoTjj/Ft0xBZjz+4PBGMn6hRyHpzGrpdb5tRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Old1K8kL; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Old1K8kL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2db33db4de9so485ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 12:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790018461; cv=none;
        d=google.com; s=arc-20260327;
        b=gGDz53if1Xg6DzOzZcF0SblIh9lZuubS+iSzjxQI4zSu0qEI8xre+AokgGS6HjqbV/
         drnKkK8USVq0EMyMWjpnFCYd/8MUOB8OJ/COGzoD1uTkgGUEIqZ9z6LSIXFoltw421Fs
         C7pXhGddHNoXCYH2WpcIjB+wOaeQplwWEhoOAJf3DXkB4R7yYSO3KeuSqemT4GPrVQYJ
         uCRCLwTjK5dRiPPCngsLmsu2zb3fqy9Y5f272rjeMP5RvHtlJdyi9lCTYoubbK1Sanzd
         jXIcURcQTD4XlQbAUAWEZuBII1qZY/opSZsaGqIkGZMowX2pfzG2uGyWxTmNi/86bXiN
         0h7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MEszMFKCmw9FeOOlcidO7gC0SHQCAcCefilt7YkTj2g=;
        fh=vNTvn0e3n0h0SvL81wH2o6HeKMhvSBXmRI+L8DsvxAA=;
        b=gibPTicHeTa80NrdYYsPgWvNYPCZZwpSgJfqFlPWBNHq6XKPU49fDq0TjWjj5iU5ou
         TgkFmZLJfnoW+C0u61lNZeub+2UHiyGBBPdy6Py5RiELr8b/147pwLOOtGUMT7cn6fmb
         3WRC1vxecsVsFOmcx9yfgPrbtfu1YWsGqA33jNvhsMqfpz0o0ffjyNBk6XxvK21G1cEl
         yidMS9udFPv9wDFTpG9FiWUWGN5hCVRQIUMOopfvZS8U+VsD0d+VPlfLmCL3ARu0KDoT
         9iWcXSKGgX33BA4N6prEJD/7zC+UJdODm03hlBmRxp+8Q6Z3Pvb6sVMDelmMUffVqrTf
         FLxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018461; x=1790623261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEszMFKCmw9FeOOlcidO7gC0SHQCAcCefilt7YkTj2g=;
        b=Old1K8kLo+/5sZfFxr1yO0b5CJop3DdWOVAx4746I2nslyAdNuiWbTaQeR0omwoiSG
         Zzdq78QuygBtKl2EqTnjPHSDMvlSUiaMYrFD1GTXi2776fM4gZN6IFwAPFqBhJTIKwwx
         LjgbgzLuv9Lmgv85zZhuniAd9okpEBN2dxyPuou+ftK3iTLp6OM768OM2/V+9aZSYW9X
         YzmUlCxYBFrpyfUmvxwcU7S7RyyIMuQBtL5cj8N6yypVhp8KTg0F9aPR2r9+hKVU8Iqp
         9lzRj0ogNKnAim1hY4KHi1x4JoAwPgXcYpV6QzshfWeyinGbLhTI7d9d4CNtfyd1+5EA
         JIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018461; x=1790623261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEszMFKCmw9FeOOlcidO7gC0SHQCAcCefilt7YkTj2g=;
        b=Zagt7oJe/C1L/ylrYUVx45WjBjWAKcFuXpMqtrcUOAIpYWgLAnuWOT6VSWSeb8nDrQ
         nUdQtkt3nMMgPM3ki8jz1SM6F04bwg7h1CdzNjMsveMCeE0Y4i2j87l3C65aUeQ4WpPZ
         +IzUMfG+H8luFdF5ynmrktjCUftldW8ePh/hmBl6oLxKXVsU5DFdKG3GEYOrtX+UdNoy
         uowzWj/OLYFjxyGc6UtwqPRGrpFA3hNEjpKB7rNKFl4uUtSqEi/yymCofj4VxdX0b8CT
         kB7aGfjrdfw6mlvELqgvQXhV3jS2ZaXobCLoka0e3QLhs5fQ7OOh20FL5OJlb5QHVojV
         tMWA==
X-Forwarded-Encrypted: i=1; AKwUvBycHWFxo0DVUQfncZ45Ps5N0a/JAvS+ERD6GpEqsFfPhhIAP5Ox0yz8jZC9/woSmOkHxH1kxBCSL5vSGG3d@vger.kernel.org
X-Gm-Message-State: AFuF++nNYVEL3N65VWJsvGEPxuxHIUARmInW7q0xi7ALEC6DPDuPPBg3
	BA1S1BAQICIPgKREFiEkU/MAUDQxiU2lGAe8TJJGbRYt0qbofRl/Iqj9Zx56JXOOLiZAjrAXckJ
	16yZ5ibLxu6z/zuXyNLdUimQ5xKxAjyeEigtAfC9f
X-Gm-Gg: AYBFou2jiuZTqLcU+4/jDGgfEwFKd3urVbuOfsucZyBqbwt2AQ5X3DXRnIixuExj0FX
	jqdbZ9f2B9VtxjJkUq/sFS2+pj5rE0euwD61Ik44vN/bIwcIFBd8FYzJkziuJzovig3LmEEpb+a
	DMxLgPKBmlZ43dVxjEHV2Huh1UyVOFevLL3eGBoqgDg7I6SnmC2vFSIrXsjJYD3NGKh3themDu3
	dTTkap1UCULGdUkcmoTKTX3E7SMecYvVudl0IGMDTFjpK+uK6GkdzbUgj5XxFXiUTnUJ0c/TTLp
	9dYdaNLSqNnKZ1jz4nPRy02oiKzg1k3bkGQMTfqI8w0pWOXlSOIzxKk6hALvlgFPN1VRvORkhSh
	1ljlhoC8cOdNceDRbIvQvEhBAEAkbSC2/mqR48swCnPhGvzuiPqI=
X-Received: by 2002:a17:903:4b4b:b0:2c9:bd54:cf with SMTP id
 d9443c01a7336-2df5a44e80emr2158055ad.4.1790018460814; Mon, 21 Sep 2026
 12:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn> <20260831-pidfd-get-paths-v2-1-c59ea6a21b72@black-desk.cn>
In-Reply-To: <20260831-pidfd-get-paths-v2-1-c59ea6a21b72@black-desk.cn>
From: Jann Horn <jannh@google.com>
Date: Mon, 21 Sep 2026 21:20:24 +0200
X-Gm-Features: AcwNN1U76ul6KsowgCeLOYWUNK5UYTHsLK5_fZAtm1s6K_0yYBp22XKyN_fzxbs
Message-ID: <CAG48ez3vJrbt+qYh5b-PYxmr2txcg3DAKDRwmBwVzNhRB+8Ueg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: Introduce task path helpers
To: me@black-desk.cn
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:59=E2=80=AFAM Chen Linxuan via B4 Relay
<devnull+me.black-desk.cn@kernel.org> wrote:
> Introduce helpers that acquire a referenced struct path for a task's
> executable, root, and working directory. Reuse them for procfs task
> links and AppArmor executable-path handling instead of duplicating file
> and path reference handling at each call site.
[...]
> +/**
> + * get_task_exe_path - acquire a reference to the task's executable path
> + * @task: The task.
> + * @exe_path: The task's executable path.
> + *
> + * Returns 0 if the task has an executable path, or -ENOENT if it does n=
ot.
> + * The caller must release the path through path_put() on success.
> + */
> +int get_task_exe_path(struct task_struct *task, struct path *exe_path)
> +{
> +       struct file *exe_file =3D get_task_exe_file(task);
> +
> +       if (!exe_file)
> +               return -ENOENT;
> +
> +       *exe_path =3D exe_file->f_path;
> +       path_get(exe_path);
> +       fput(exe_file);
> +       return 0;
> +}
[...]
>  static const char *get_current_exe_path(char *buffer, int buffer_size)
>  {
> -       struct file *exe_file;
> -       struct path p;
> +       struct path p __free(path_put) =3D {};
>         const char *path_str;
>
> -       exe_file =3D get_task_exe_file(current);
> -       if (!exe_file)
> +       if (get_task_exe_path(current, &p))
>                 return ERR_PTR(-ENOENT);

This assumes that when get_task_exe_path() fails, it doesn't set
members of the path argument to non-NULL values. That should be noted
in a comment above get_task_exe_path().
