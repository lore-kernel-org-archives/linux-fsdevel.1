Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592814;
	b=HOJ9l4M/At/ZS/6BXLFykvUwpFTFNKetivakPrbmavretnnkntzX4okYiugBvPVE6Uby
	 +0li5tx6Ml1X+YvZFtjNJDpTP8tCrc6Hip2Sx+CyY8fgYFHhVxvJjVi0WZ9xBTMI5UMGy
	 NUerrd8178GrAXSd05XDci2XeD4yQb10tI75+AbDBcPSQtma4tiCnvrWNnoMxSFffbIYJ
	 aiz7qwDis+HwwwHxAwdzAZUp3IMZq7qI0HEdIv1ftFhcMBE0Ld5nYy2Xjku4xh6+ORxaH
	 Ctk+59ZReQZFzjMWBefO5UfTnurriSzjqWg0tNbgeXxk3+FgyVYnQoIoiiZl6Jn2cFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
	b=AnJJGC5c1PsZs94wOv0IL4dTGkeNdJW6/v3CjVpwJOtgefpiGABbPCPy6a9vpKR9C5nT
	 pXQ2BwinTB6SDENUFgWfg1LsGn5aDsWI85u9n0Dl2XJQoxB12/3LnExucVezpOx0BGx85
	 rUkxIAW0cXnDWb7NNFyssZzyvKB6Ol5lVHybC7w9C59gDvJtfQXgwftIJsIMTWEB0qmLF
	 2fLLc5vI1hyUy3P6ZFhiTs5oSNzDqsH01TbHd1/ZlpY4lLuVJ/3WPkjjagaXg+phZDe87
	 ZnKmp2+w2bnfsowgcchmmETpfZdyNfkX28SMxB3mom5K+6/PgakNFjkoQ2wxcAArhHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C71606A328
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C71606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c423b145922so98413366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592812; cv=none;
        d=google.com; s=arc-20260327;
        b=AwAGpYVNtj65c/H/i8Hv+H3ZE31CX1sWH5gptwHInNHl49sVE78rH6hfCuOtitw0rP
         Spu1fmm9zENbiTN92+pQMA5OwTgUnQFnFTSpbzYDA8E/TUTW+hdYH1t02EDST05Qd6Cb
         9BiVAOb6IOpuWvTXwsTKpS9UINZ51K++ZNa9ok/sVHNLJTXQwIAxXrsZ47v6CH/aYsun
         iGSwxH/blKDU94eUonuntlJLA4EUEtn/4Vn9xCGyM2wsRKDciSZfdZ+eHDGcxaGmrMGH
         9bHMFjEfABJGBGv2M/gXLKn+lVU7X3VMCCjEIuvehCT/41gilpoDl8ruA+20c8ZDspY5
         wM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        fh=owYz2WMrDLvq6P9zJLrZ4e0ruvv5EtTuUEk1r51yV+U=;
        b=m97OaZk4AdkwnqaejXFfJu4ulRes4hBzZQ8gF3ffIz89QTu2j3EUr5nhnodoXa8jUX
         Zd1tQYDTSCIJqtuegSF31f1B7udBRbCIDRmyU5A10tPt1/CovPC21Ggdf43CFjXvRg8v
         +hScoEqzsLbengG3al106uotN7O/2GpfutiilnRsQEsZMTm9cJ9MG9mRxpz4jCljpnFu
         2kkRSmlZLbbqRsGe1/UtvYJhsH5VZ/mp/+KnlkKGQIC6RWSXcjHH+ug5yN00LHuCZpyj
         orKXeePplCdfkBrYnQY5kGtfkE9PmeEM+lVjNlEHrd0zUg2XyHy1uJ3S058TXz3IKrTU
         T+5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592812; x=1793197612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=BRqHAhOJRFQGCZ0436cerbXsvDGcjOTtcEFCOpJRV+nbVKbSAKMl662tBLFTfb2Sg5
         NFxQNyHoxxgYHQR13h13k71ankQp/N0fxgwfPZdFZZwD0LZwBvhOQiky2tnvBNcGVE92
         vpRJ7hzp6lhKrZveGyDGkQ94JZjS5rrim4/SQCOenhyqo5st97RuKWVFwTkWZQ5bTbIw
         iWX7FjROAHIvHplEaKREmJYGpSp7sUQFKLAPhXVjYlSpM8WQnUK4iSviJf2DCzgxJwf5
         mmlBS+ISZT3vDsrX9Xx3+f3KYgz6TnHUVdIwJP9bY9OfNIdfJdTh5lFsIo+qwhCRzOmH
         nAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592812; x=1793197612;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=wtlBrpJSXmn5k1QBHpPxkOFxYk7XnwjZ+TWzOlaB84BTwT4I5H1suwfDd9+kTUDcW4
         IiWgMX1RbRMKjmwFE0TFXxfGUrYjgUbVuEIeuCOrYr90pROezfhBzFRz5o+8pSAg5HAO
         r4B6bkbDJpjtKrr+o5MmRjdMmJwKUt1KW0SpiykCSGaJc8XFvY4/+LOalTVSQFY9czTQ
         vGjKeTCQuvbC/ClLpfyEzlsjG2GwCm7CI0VjqjkvyULA99pXPTqsYIdznU+01EfAyFj0
         86qwerSVBfevG3MhIdjZE4vXr/vjnpg898/enfhm7I34SquexE2H3bBmWtuWFW+4Pyj0
         LM/g==
X-Forwarded-Encrypted: i=1; AKwUvBzNcCQQJt7HQL1LhkO7b1Ri5T9lBcnw7u6QrD9/uLiytosS2i12Yi8p0JTR996pArklU568ykrbUzZ/HvYV@vger.kernel.org
X-Gm-Message-State: AFq9FYKgJPnSblPHqpneHvrQHiU9Lj68DgapqM2+1kDA13AzCFGX8NxQ
	/6Y3C5Byqg+uZK6GXME7+bz62ovE0ZkT35BqyrBmV72rJK3DLURMTtiiN7aH1O9WQA/8Mv6q/WS
	PCWxW9ZhLiYEV5KUZ8Q/6aV3yqXu5NpM=
X-Gm-Gg: AYBFou2uHmV1zj6U0hnpj5mKtLza27At+ELRN7dTVLnjWy7WPQ9gKg1wm+ZBhH4UEE+
	GBklBPt/14fxE69XCyJSWgxw/EJWR4556nEdjfhinsk/HuDKd3sdr+1tRCipWjKP/fcJw/nVMgj
	tCYoiVI0mNtnZ6kvZUy7PSDIOgZCtPqEO02pZeeqzAfJcIRrIjxr2FUYWFJlD6bWefQT1efAS7D
	vmOoP2XkY6OY+0t89Eg0wEjnPQQ7hZw5/V6Ln2ZwlqGTRHVw03QRDPZJ634LpF9nHWSVaC9Gtcx
	4JtqETnARsFmA3IkX3ctbRWx6AK76MWRFyKkQ1N+Ew9Ep2J3U0w9Sse357B1b6YBGWOnkyO+0lv
	zAtByECoV7PR6O8GolxomwzeaJR7w7jBcqxYF
X-Received: by 2002:a17:906:c105:b0:c33:ca5e:8ddb with SMTP id
 a640c23a62f3a-c46796b58cdmr190770166b.28.1792592812271; Wed, 21 Oct 2026
 07:26:52 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de>
In-Reply-To: <cover.1792552161.git.jan.koester@tuxist.de>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 21 Oct 2026 16:26:15 +0200
X-Gm-Features: AclHuK9oo5ZYObAiFZur0ih7xDKEBxlKdO-BvoDx6w0mXhpoTx1_PdEXJcogV54
Message-ID: <CAPJSo4UJPnhLFAYRXE-_M2_Nin6=Ff02AjayD10cB7946MvJDQ@mail.gmail.com>
Subject: Adding dreaded Windows SID-style, or. Repeating history, the bad
 chapters. UUID/GUIDRe: [RFC PATCH v2 00/41] UUID and GUID user and group ids
 (*_r system calls)
To: Jan Koester <jan.koester@tuxist.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs <linux-nfs@vger.kernel.org>, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, audit@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 13:24, Jan Koester <jan.koester@tuxist.de> wrote:
>
> Hi,
>
> this RFC series lets a user or group id be a UUID (RFC 9562, version 4)
> or a Microsoft GUID as well as a classic 32-bit number. Processes can run
> as such a user, files can be owned by one, and credentials, ACLs, keys,
> System V IPC, sockets, signals, audit and procfs carry the whole id.

Are you Linnux guys aware that this is just a variation of the
*DREADED* Windows SID that this patch tries to introduce, just with a
new name?
Maybe, before doing this, read about Windows SIDs, and why they are so hated.

Secondly, the whole idea of doing 128bit hashes as UUID is not new,
IBM DFS had it, and had many iterations of security issues via hash
collision exploits. 40 years later all this horror comes back. Does
history really have to repeat itself?

Lionel
