Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0A548573
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906166; cv=pass; b=sHD50FB8Xv0Py6uzRJgwQc1soQAvXnj/Uoo+aUmWm/P+VA4hxVbQ2pzSvydgri01ZrvfPPy2+nOJhym2VxJOK1pTKQHctOWwg8+ODmThpA50Ehk1/Ndg4WFw6HSL/QWCPA6W+DurJaaBJnoVIcc4/ulHXwsBvsISKUtLsgeUbj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906166; c=relaxed/simple;
	bh=PUq1upF8sqxzV9pdAF0Io0GcpgTluz2WtknavoZ1se0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfpjE/0rX5qmSUDODSu4MpLiYvH8SPFBNvpsfPEdo0741yNc9EQ+6Kwphn13rWsOLJWLheVosyO6tyYabGMHq1GOxGg9kaXaFMge4kurF1oK6TPbbK5EkzjTTpp1lwF8hCIIYdcg1gfBR0P+1HZKpgjXo1W2uGA+9FQxZUaULGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ADQf+IEV; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ADQf+IEV"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso401219a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 15:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788906164; cv=none;
        d=google.com; s=arc-20260327;
        b=O4PVwC6YFPtstuUaKhqHtZRAQuedMEkZex7qEGHYas2TSnxF0l8iT8kJ9+khhbgIpy
         5ORgiotZOypKFuuWvK+5UebbYmggcGERW+bMwIcABY83E5/XZrYsdZtUplJWDH42NfIS
         I1//WruHvi5+weSWXIPQ8h1yb22dPtSbD6jrKRvfU43Abmoq58N/i6qgxkJzEkQAb8da
         RntBZXrkz3yWNB+MKy722V+fk4z1oOdPgKkpf4tIF3J0K4EZowRgq8Lxm9ZyjoN95Dp/
         /0I8p/mAIQaJHkgCVjjNWYP6+5RksZsV5IqQf4hOLb68MRujcuVFdv2JFFpDpcl8TgzF
         7nCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GVzoIRFx4d8U2lI4YaT8ti2726pFUpvpJ2c4Ljdmqrw=;
        fh=HKihSZ3fSwkAsuHps82fpKctYa8Rehl8KBXhlN47Jww=;
        b=qv5TeKjDJ7Q/7qYSGr022SoTZDTrHdmZ1D7hL872QSbCUxxZvZpxU0pqFaecp4P61Z
         KpQiqhl5KJc4fAXzDCQZ3NuYVgxXINXAs+1KiEGQJx7BCaWoUZodqvoBR06jDHBaMweL
         8G3sUchnd4HdZodhSZTG1KuWwuLY+VhQ4AV9UXicZzP5v+Ye9F5dI37ueWT0E36JGTv8
         AeeYoMBS2zfc4tuoxnqGZR1rna47IuSW/M47E//69pUYDK+RKwJvqv/LneDTwsCaDggO
         C78tn3Zyf6zfNIK0ugkIv+T8MiirHMoCGiJEbzWtRCjKh6GBPjg7d0f91BuvtWlPJ1mn
         rPHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788906164; x=1789510964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GVzoIRFx4d8U2lI4YaT8ti2726pFUpvpJ2c4Ljdmqrw=;
        b=ADQf+IEV+XTvfyOZlkBXk3S4fTCk59irlh7V0Vgz8LieQe1WKobpUp+7TeDkoJ76mx
         8mIJ/npiXnoETDfvS6WbgA87KDj+3dSJwb3e/J4fa2YFqZ5Lsgao4MOkJC0BQz5tgU3c
         Xsku0rCwrleZpGcAdWHfc+xrITFND0c5jKlBPYlbhlKdeTda+Kv66Cvc+WWzMh+RVRAY
         WyvBvpjKTEsXse5yZvjrGXcqNw54HDIgkudzq0X3pXCQiPidmVYk74o4l8Wm3Xv3bMI0
         kGR7p85aRkPPMEJRrlbbC5lb5oUXjMCv/EsGgzTkQAYSo0EZoHAxR8r2Rv91uQvYDC3c
         fMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906164; x=1789510964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVzoIRFx4d8U2lI4YaT8ti2726pFUpvpJ2c4Ljdmqrw=;
        b=PatLni0OBzbZSiTO6Uzg/rms1bbeZllvjXcMsy+F7DLEMmqrKNN+i2rwOi/Glqs891
         D0Qios4IM9dAtZOIc/S/V4/yiKyNPnvyVOcfCefSU3ILUnFtWyvDN8DOPYCVWoj5Vj5D
         1nI7vQ/8dcrJE9cuBxe7Iax3mIo9bMqYiOKdEutXlIKh4SnOkZwFsGZEgihD1Ke+EASq
         xeDrBiaIlkk/2DD4CObDB5bCMNuCTQIsllXoETFLFhgYzMNdicR5/n4J9G8t5ZZzcoeh
         FkGCzbgY4l4XSXIz449/sKKlnkZQ47EcR+R4nozs4E2udBjiwg9lWguZIV/GwlhTFkdJ
         Yu0w==
X-Forwarded-Encrypted: i=1; AKwUvByR7s3a+7WeHxNr3aJyWXp9M+x8xb7ud1rzmzzxBeqL44JLJ+0ugFcbs7/Ym/wNwI1njHL/MFpfWQPvJ6He@vger.kernel.org
X-Gm-Message-State: AFuF++lFb9Fs34rgMvr4L4okGQXUiyt7kKASX/QRLjMaPgq+wBf90RmE
	1+C1HGB+Xm97rUU+uB98dC/Tc7oeTSIVNy7iPCZdo6Zxklpo0WvmjSY7mMmB9NTr91jS874GKBn
	26+uhF6FkFCWOA2iBihyOsMacvHvzyEXCXOnlcirxhcDQSE2m5nij3w==
X-Gm-Gg: AYBFou273sYqooc7UkSKbIaUNwqeItsHvx13WiC1n5LnJ5sm4iHE0byIeQqe0xRQrH9
	bpgA5O6FlLlr5zJzGjkSLPFq0Way5K551hYnQJ5Hh36bJA/lpZfmrm9Pz69IaBHRTevpjMUbq+y
	t43HyIPzxOMQ5nGObSkZh1Eftt4IMLIBn4ACItUuj8KkP5mq6KqMnZsGi/UnjTLFAJLdI8CzrFz
	qpwub1yIYZeAoCE1A04zDK5ggA2hegUyCYLCR9/IHrMHSAgPhsERlDjvvqupkP7x0wtSseqlPPp
	FmfmMYF5kKQwNOev+Ft2I6NwzDxl+862hgUZh+k2nBvVQ5N3lHYLee0pVioT+0+m9o52cxTFX0a
	t
X-Received: by 2002:a05:6a21:339a:b0:3d3:adad:f171 with SMTP id
 adf61e73a8af0-3dabb2435bbmr3228521637.19.1788906164497; Tue, 08 Sep 2026
 15:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com> <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
In-Reply-To: <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 Sep 2026 18:22:31 -0400
X-Gm-Features: AcwNN1W9OmnuMX3-XMMtyTUW7_31O0rrjQ-nOjsvHKE7uL0nofLludafyjIWJ_s
Message-ID: <CAHC9VhSmpwpvjVPaEKVVA0BnYkn1M+-f4wYDb8uvcL2MQfH9MA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: verify mount idmaps reach inode hooks
To: daan@amutable.com, Matt Bobrowski <matt@bobrowski.net>, KP Singh <kpsingh@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
<devnull+daan.amutable.com@kernel.org> wrote:
>
> From: Daan De Meyer <daan@amutable.com>
>
> Extend the BPF LSM selftest to exercise create, link, symlink, mkdir,
> mknod, and permission through both the VFS identity idmap and a real
> idmapped tmpfs mount.
>
> Record the idmap observed by each hook and verify that every updated hook
> receives the mapping used by the VFS operation. This provides regression
> coverage for passing mount idmaps through inode security hooks.
>
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/test_lsm.c | 231 ++++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/lsm.c           |  79 ++++++++
>  2 files changed, 310 insertions(+)

Do any of the BPF LSM folks want to review/ACK this patch from Daan?

--=20
paul-moore.com
