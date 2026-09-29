Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650E28DB54
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690416; cv=none; b=oq6dU0odlMTeMjZBVDVTKiqUcJCltFgXAsoY6WbaZt0uQ2gges4mRHV5UYCwIavzzSvKUndXv0e1OA79Gdt8NgdT4X7DLDgSv2nV8K8q8e3ixUFI/eFh2YDBR0l8W9sEkHi0i12oi0tk6NafxHQPhy9SaHluM6MRSdqD2pNIhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690416; c=relaxed/simple;
	bh=MB1KEcVb+uH2ecGVyr4qpLqKb6SbBgJAInb15YOv3bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgRDEAb55hrunM+rokUBqgB+xYU6WHpLqYOKeqYI+aj5SG/zX92lqoyj3UpK2yDU/XlATZ+rLoQsDFAfM+vthwjfglcBVCfUTcVkz0H3p6SGgLLPzu3MoTf79yC8pefOMQlI4TuqoL22fHKk/8mxgMToBORrgvlUpaWFXwcS2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlqnDlBJ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlqnDlBJ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so12510905e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790690413; x=1791295213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x/srKavlgqYlrzFVROF7aG+7+UUAJd3JIGxu7I1XKtY=;
        b=FlqnDlBJ+Yz80ZO1r7yWk6Z3JKIYQl6ehX7Bg3eVFmKOhp8/wH4AnIonKdXycTxKUE
         Cg+3vX6yUMGlM9Ba7L1AKY8R89rQPhhuOEEWjoOsP20f64ArYuIgNZOWGxwQTEq/o9ap
         kuRXJtP+kJ89vmGOrdMCkASwKsDOZXlQqsF2D8uPvhc8yTuD9eCFaVUYxuHDY/1KLk6J
         0A8NmJfEU38xE1O7qtPbzju0qmRKuvq0CcQS0GNJ4hu7tFO5UPfPiuJIkoSX0lfM0cJG
         EFnrij3Xk7K5i7tI4OrawzUMYr/T3JLwK0/lQ3FQi6mnxLeh/5RZbLXBp5UydF3SFYs2
         +j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790690413; x=1791295213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x/srKavlgqYlrzFVROF7aG+7+UUAJd3JIGxu7I1XKtY=;
        b=mwByRk5nqbo85MWblm5AU0J4bn4RQQoqkzy7sDgXHySXsEOaCC2sfqcsHzPgzsrN9j
         xyO/UbXENnv0wq1+DRpE6nyZL9erMV3AGQSJShl5vFHKmROZI1lzi0PkCL1qlFGMJE+u
         WfunUSIHqREVNoO+xDQ14WcL262HtTUvdf9yD6hLsmZA/WV5LOSKztzf0pD2FSLAnkHc
         ejAsILkoDCKIN1VTX7m9lwhT3kFFI8Bf6AsO101Pu6VzN7W3HaAMC6etrejibD7UvnZ1
         yyD5nImHqWng0E2rdkHNBCqO397IwmkIdOsjhotgdDMJiFls0dNB4mNSlSKQN4lkoRRA
         Sb7w==
X-Forwarded-Encrypted: i=1; AKwUvByzfDf14Xsqfg6S9EsaSDegRnYJILw/mInjLXNalPFBb4G6Semg6RD6yaB/kA0igfZQizWpvlDkgu1j9Ojw@vger.kernel.org
X-Gm-Message-State: AFuF++nhA4iK1gYJ3yt1098Th6vvgK3cPnA/k6hkKg/65nqHnYhHLguF
	/IhMEHJJC4gjLy933iNmGdtOVdvKs2ubM95Th01fB3ahj+vrUsWZM9QGYjVRXFZ1SUW+
X-Gm-Gg: AYBFou1TpX8L19/x/k2wyPS54RmmzZQzVBd8q+gb5hINGyOfDL0FDD54Vl7pyTv40Lh
	jpY5foGifGeXekjQlRNaM5SA3X4qu+O31i5ZksViEng2ZCXO1PGfzA0ddFcOqzMMhmeZEzJ2TUh
	ixl/1PinmR1570No5OCUi3wAgDm6RIJl+gE8ZD/GLr+37IkBSsSSYjISce2WSq51Wa78L1oGpQT
	oBCBTNcTUqh2C9cWxLjhl59kQT3obg0oMmDjDrugZ8j146VJ3zSpQD5Kya2XcCZLMdKXesEosbJ
	no6TjYPzgke4UBf2bx50BXlI6qgEpUyfZ9tGQdq7wchZdOx1pwPuH8YIukvsZsHzixvsfwhF6Zd
	IWvg7rx/uNo1YHaP9C5Z3AtkaRyyXhni2gpXs/gY4qaIJZPiRvS5AWXt3epljN/wCGHVTolb1If
	1oDY/1V0vosoedwmn8u7A4nviKL5wW7XVt6DEI+vB1O6NY0+aDE3UUMv1VARzMB1ZoplL3PUhMu
	Z1/K/6o68jXGbb77TQqPQ9luEUspJFqGbLZtIEqdIPRlVPWJxu+XjBPZsihjNjI2PaynC22ahYK
	/G6tM7g=
X-Received: by 2002:a05:600c:4695:b0:49e:7d74:7b7a with SMTP id 5b1f17b1804b1-49ff06b2c70mr225355595e9.6.1790690412769;
        Tue, 29 Sep 2026 07:00:12 -0700 (PDT)
Received: from Ubuntu-2604-resolute-amd64-base ([2a01:4f8:13b:86d::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013cc0255sm7184465e9.1.2026.09.29.07.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:00:12 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: krisman@suse.de
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	danielzgtg.opensource@gmail.com,
	hughd@google.com,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	tytso@mit.edu
Subject: Re: [PATCH 1/4] shmem: Report casefold setting in mount options
Date: Tue, 29 Sep 2026 16:00:11 +0200
Message-ID: <20260929140011.211148-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928213155.2612039-2-krisman@suse.de>
References: <20260928213155.2612039-1-krisman@suse.de> <20260928213155.2612039-2-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026 at 05:31:52PM -0400, Gabriel Krisman Bertazi wrote:
> For shmem, casefolding is a mount option.  Report the current encoding
> and casefolding flags in /proc/mounts

This works for me, on 90ddfbd19636 (akpm/mm-unstable), x86_64,
CONFIG_UNICODE=y:

  # mount -t tmpfs -o casefold tmpfs /t
  # grep /t /proc/mounts
  tmpfs /t tmpfs rw,relatime,casefold=utf8-12.1.0 0 0

Tested-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>

Heads-up on one side effect, since mount(8) builds its remount options
from /proc/mounts: once casefold= is listed there, it gets passed back on
every remount.

  # mount -t tmpfs -o casefold tmpfs /t
  [  527.593309] tmpfs: Using encoding : utf8-12.1.0
  # mount -o remount,size=64M /t
  [  527.595716] tmpfs: Using encoding : utf8-12.1.0

That second line is shmem_parse_opt_casefold() running on a remount that
only asked to change size.  It calls utf8_load() each time, and nothing
frees the result - shmem_reconfigure() doesn't look at ctx->encoding and
shmem_free_fc() doesn't unload it.  50000 such remounts grew kmalloc-32 by
~50000 objects; a tmpfs without casefold stays flat.

The leak predates this patch - you can trigger it by passing casefold= on
a remount by hand - so I sent the fix as a separate patch:

https://lore.kernel.org/all/ba38f80f629fd093c77f3a49fdab7b71ee7bbc5f.1790687276.git.med08elkadiri@gmail.com/
