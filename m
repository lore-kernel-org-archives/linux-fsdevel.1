Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73D30566A
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682895; cv=pass; b=CKo4qtBsGAe70tfoPRGdEL/cXVwt+8oNhRAG/+6RsFwh5R0lo4OtjUXoRlanm7H5D8NR/zQw9MXK/vvH9gFNkkfKPbu2Ii8MsYfFXHK8RJVhSHvMeVak+DJXixma2SYAhHbGvO5HXngIjzTSXWrjUWlpeoljCPtZCpgd5xyeu+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682895; c=relaxed/simple;
	bh=8ilDxhAiB32IqOC3th8HmSfbryjwzjesS/MpZwszFms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDT90smuLfs4bGDD0W6LMOwB6tkdokYEsF1nxKz3xYKEHMHo+kGaVs6YWG9rmHJjYEBaTBPSsiZlWuGOKNcWAMe+xtVd1uPgTQ0WaGhAOOFoVAyCwgBZdslDlDaGc/ZKN0MnDa75cW6WsjTQSDH8+8TfcymXz4uvhrezrD6Nr1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ag6bubmy; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ag6bubmy"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c85822059d8so1432256a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 11:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682893; cv=none;
        d=google.com; s=arc-20240605;
        b=VVPNGck/PTOFg9DFY9TW88dbPZZ1w0/8pZjS3XaqyyVNtlueDOZ9HmF2ePT/PAn4P+
         Fmv/6rI2bEINK56dHnX1qKu3AHiSBja/bkW2p3wmAkcIbzIHlLDk8Go0i/pDlValbjnG
         v8eMdZsUVQEjTxzMzTGcU6eQnCbuUwVnWbaUooO7YlU99LIHh/tnw0LHWC7Rh6I0dJBa
         euxtTm2eOAchCYoJ39MNZv4OPiYBQJExXNSoMrXYo+PlAwvvYHdX3tt4LQsqmpUil/th
         YecdGdcrnrtL40VfE7vWWDF4Wry5fGE4lSnhttQkDBjGZZjsays5lsiuorB7K8YZTUGR
         1AAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V1+sYntU5WFVxPkxcqomQF7fzW4LgZDONPtKqmZffiA=;
        fh=fOCMeK113YVx5+4H1PdylSfx3rKhjmbax4AtVTDRWDw=;
        b=blNvf60EUtSzkOo4ylunBrgnUKXw/0RyJhNEOrmq2sXKGzGkv+C6sxkDA4rishv0+4
         k6gDEIUrJA6RcbG8vFqnbAmIoYPAwcmal2cyXgxw1Oqfb06dz0x3w5p/9ljGsMjlEvJH
         se4UZ80UWnSr7AGMAKP39GyLftsDoSudzAr9Qwl0TElC4NdTHgYDLqSpcEnI1BhEYofR
         ir9vBuG9zr1nggDv/QfGbKV+2Sb4jm1+FSk7N4Nvov+3R4UVvL0A6vy+dBzTB6xAFWzL
         zw7lp8B4p6ar3hVlDlyzN879ir/tWr/xnT3V8MU6UQIpJljJuP7H9S51ynTnlEHlD5vM
         ZpVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780682893; x=1781287693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1+sYntU5WFVxPkxcqomQF7fzW4LgZDONPtKqmZffiA=;
        b=ag6bubmyV1LSITsOZ18m+UPiFqAyqHSUlSrkViApHk4nrY7QQ4nL/ZA1gxLW8aKFxm
         Pew83nPhwuU2sUvTBYuKuIWanVJp2/Vic8YGdvzdOmVIzddRpAAEW+Nehi3m7SslhxpG
         89EAKVSK3X/QQ8FffyXFtUL9mDF5DozMxgVzBvtu1ZR3bbvV18YPNOKBWlsDRDUgWtek
         vOaL986Iy4It4J8QLbuzaRGjs5M0sa3Zrhh01GYoOparU4uhhuYabStPGD4HhOU1ht5o
         qEx5Z2h9USPgNqLx2XYCbjmqc+whoS0wmeA67NgHvbvAZz/SODOYbYGOhs1BIzHb3WdH
         hPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682893; x=1781287693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1+sYntU5WFVxPkxcqomQF7fzW4LgZDONPtKqmZffiA=;
        b=QNOcrnNSj/FuZhR+ztit0rbX5/C16hiT8T2G5Xq2cHx7vvIR4pe+nczZ0krmIe5Z6W
         hn9YHYj4T0aA/tIUiczqgsZkAtlORHvuNwmGb5f37llKYpU9DOdpMLshG/Z0oBJGqSf/
         PMtfhiXKbeyy32QYqvSlLNgjvORYuXR2PWgol9IcvgnIl+kpYNMMJ8KrbDUeiT505QvJ
         kMcjiOudUlft0qK3sp6riX6YZrrOws+RLEMEiy/EFf+KEm8dflCJsB0C0CDqdA4KUnT/
         3RlNpiNxj1/g1URjYnFnGeSCDOfbhxLwIKRDqRwex5Fxs/njY3r7FZYfSVOQ+r62X4z1
         WGbw==
X-Forwarded-Encrypted: i=1; AFNElJ+umfQlC1WXqJ+9Z2diFzogXygxZ+gxEznlw4tbTaVXOKMqbAG9rftWZG33RzntudpTcZQQI7X4+6vGO4WB@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMUoGz3NPReVgiwFdY3Ib1cwUhq04oiqeaDv6XyXC+kMOnk+y
	f/VNXnUx1/YfoB3lwwE4dBAQUdU/yMy+oqfptLnesCj/iwDrZ+kqe6T2wwWebXDPalLaLXjto4D
	2C/bK8deHU4/vdlLFQ5O+ht/cYdWxiW/Tc6/v9ALH
X-Gm-Gg: Acq92OGZTwrXyxJm9aQ1W26cPFRDvlnOm3vTrc95kW0CwAX32tEV4X+VI6mnG/SMckq
	EHA2GC0DYaJ3watiMSZ09BspoM4KsKtzM+Fm+Fe5L53BYQk2fgCOj4lxHFplYP4BiDjSvDc0mH5
	+apT0W7GF4fAixc8F1BYokDXy/JU8QKfcd5KTMaI9uRxbOcNBqGOQ065OvYeDBa5NgDw6la/oTB
	ggT/Nqz6CrgTr/ZNaWOwO7OLPyqB75NiM7p85Ce4KTY9DDYmuKIKJ2wzJnzTlfTBXkAMdIfeOiw
	0RpsKkg14gOWWRVZHg==
X-Received: by 2002:a05:6a20:c70b:b0:3b4:8fb2:a350 with SMTP id
 adf61e73a8af0-3b4cd03dd88mr6135775637.34.1780682893128; Fri, 05 Jun 2026
 11:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527181127.879771-1-mic@digikod.net> <20260527181127.879771-2-mic@digikod.net>
 <20260605.ieZ1hei8Ahna@digikod.net>
In-Reply-To: <20260605.ieZ1hei8Ahna@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Jun 2026 14:08:00 -0400
X-Gm-Features: AVHnY4IwAntIgRXRqihwKQ6FMjOdPIE04f8IHhmR8rRKjjx-CP4eO6M-6Q_FY58
Message-ID: <CAHC9VhQdT7Jh_dXPk4PMSomZ1JPPsm6ouE7cHQb_3=BdY37j6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:07=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Paul, could you please take a look at this patch and the next one? I'd
> like to push it to linux-next to get more feedback.

I saw the patches Micka=C3=ABl, they are in the queue and will be reviewed
in due time.  Considering the delay in getting this revision out after
my last review, another week or two shouldn't pose a problem.

--=20
paul-moore.com
