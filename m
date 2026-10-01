Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F0357CE8
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829512; cv=pass; b=DMNq3iZC15b8KSLo3jZVT5AmCDlGFMjONRUUaWzDigN0QDpTkhxuEfRq265U4zFkl3ytKXYoS6z88p4lMF0rTVG677JgWo/4TLRFcwASR4fpUswl3kIECqgLARUtKLo+zhqaiY0RTYQgFxim7TYu5qFeMKwIuAXqFWCww3IhTNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829512; c=relaxed/simple;
	bh=RzZXfiD796BISLE4d54SM7rERI/SYqzCPtyXD48JKMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtGoBPemupmoTIElv+XgnOMF0vGn/HAZu11olShiGhEcaM+AhCcPWTiSIwbfRTizIAJyGg1g2ANYr6cfgxWNPyHB6dX9R0f+KRaDe7E2B+V//RTlYHCP6LReSsBJOEFqD7NeoLEeT29ruBlUshrKfmwrQTpE5UCzPr7E7FzA8rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxm4Q/aH; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxm4Q/aH"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34ca54bfc48so1815644eec.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 21:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790829510; cv=none;
        d=google.com; s=arc-20260327;
        b=B73sRwfHx5S1W4x8cR0jdsbkmVbko/6oez8o+9EbIb1GGtPCiKfPLdymgE8NtHul4D
         zkzBW77vaIYekrB4pVxTtxJB1sCV+jwF/vE+9xQIqOJXPt7YPkV85wgd8eTfiETsO/6H
         FuAL6iCTIxHyAPn/CC6zhrWNchGl0n2CEeLlAAATFMTkcwAfVU31IBWf6S/K10kriaEi
         CJG77lKaYL2TGzgL9Gyku/gBbGy+iYGXfm1DM0endeXdPjUWx1sfcZ0fPFDWziV6+a6l
         LCk69jIeQ5D1RnAONKEJvY3H+Tx+NqudNdXtvG0ShOf1oapaMGbIaWNITQ9yHL6NJqLw
         AKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RzZXfiD796BISLE4d54SM7rERI/SYqzCPtyXD48JKMw=;
        fh=irMGxAyahtLebjjxYQZJF2PYjGvg4USmqW9+R0ME4wk=;
        b=AgQL8ueKo/P8mnd+QL2GVd4yBJjO73DV42qj2UUoOMlOZO0WU3K7vhZv+Wi61BObv7
         2VL5j+DXt/ri4aITF6P5xYRgI/97oQjf03BmraBpwslRs+jR0sF5Hyhu9/HLPD98G2oI
         A/ryeI4o1x8TNS1hrtTtVNEmCrJ+zJ+1DfyWhyY81fUD/dh7Z5LDki/s2UmAW4P/W4TA
         FGMnEYd+LsNA+8dKEn/HasYh2XnIB0tWAiH3nhcoPRxACHj7ZZGusZPkzxotXCQIQbII
         VCZje1SRUE2TnjRWzLcELyhNJConfD520fY1/P9OxpX1nMTADap0edi+ABhHXg19DRpN
         95Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790829510; x=1791434310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RzZXfiD796BISLE4d54SM7rERI/SYqzCPtyXD48JKMw=;
        b=oxm4Q/aHHtjIckSdR1pLOKeqyLX0OMGyF2aYHj1zgxq1jAcax71VpqLs+cMVqb+zlB
         0xh9jybedlrK5jDsC33dlXfJjsnISRuGwi6Z0Se8ls49+Xj/m0JgcDr964LDMpPTXBQX
         /yDcUbmn9obEkfzCmSF1bFIzzr8/XJxZNiEo/9AA0lsRLMG6UFZXeMOdIhG6GwUOJa7f
         +jcIyYQjzVIvWQOlAKme0sopXTi0zPJ+cyojivzQfKdilJAbLHBkVu4yZIKjhvb7nC0i
         5rBiV5hjbTIHFlCyF/wBe4CoGL7F6ATXg/utTBLWr1S/ph2PGaxQL/HHA9UYse+bwyeC
         QevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829510; x=1791434310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RzZXfiD796BISLE4d54SM7rERI/SYqzCPtyXD48JKMw=;
        b=26FpSmzkN+DGXBuVa4cZLA51qLZk/MwxRBfwt9XwmE+mVQZWA9z++4eRcnZWuocnaB
         M2AlnGZAjWcn08aAIkwHfhVa8TKBaTrUtoIeNp4Q9QgNBaNTw8SP9oZZjjLFI0BhBjEe
         TjDXJ153EIJtnXixYOz58u8C9bq2zRcPuWdQK2FvXZSsU3ziBg2lOjN3wwl5z11vm0RQ
         3bB6a3Ilt0k4xPM8IiqrKMPs8oB260ZGzrXt1EtVrxDX0IqV84BVBOze4oQqnCtChtNU
         pK4Ps61Dl7q3INTzlTfjVhqpDnn063hXJ2GLgjIv7TbLVvnzLtBhAab4pW/Z+pi0XnP5
         cyEA==
X-Forwarded-Encrypted: i=1; AKwUvBz6d15p+zk0TXMpRdpjqtoaq6k9iwztoq/MKswkdoYLYpljVarVIBMbNXglbTI9HRh6I89qGIoBWSe26sv2@vger.kernel.org
X-Gm-Message-State: AFuF++nh0SSoRZj4Zgs7dW8uKPl4+KSAjHrQwUDC9nHq5W34wLPs4kKB
	mrij4SY5QDet+H6Fa42VvMW3mTLIKNNky0baY2J8Bif2Jfn9jIAP55iaxkn7wc97o/9RssS4wkr
	GmO5xZC5y5j5sP8JCEhaE310N0voTQLeEM7vx1my2
X-Gm-Gg: AYBFou2CpYjS0LExjH6C3gI92jaq57qDWgP4KLkh++/6tRvoRchZojo8zj73lWpt3dC
	5R2SCTRv0suDc/9z20duAz3Xai6K/o9CTm1wjcxA8SaiI9tutcCKPrxYgSDN45eEslneY5aDcpb
	oRM3kuBThQeBxm3jWQastEkRGb/3ke2cAg3iAEb5n5zk/AT5n0gOShvNOWlEFWHTHrZVntykUIw
	iKaHI6FT3wf86e/BL78DBikTW+7btl460I/qwb8BhuZDNJ8xsG3Ums2Jmj1ifoaHSCmklHfnxFg
	QbHHsf95Uid3XMuvMYBRmmTNcKdIqwN+IVDgmHQQZ7aQjKK8mcXoVAyPXXBr/1Q/9ygwIfTli9W
	6oUFJ01TI8x0mgeFvQwt+aM/UIPxdcdvPA/ntcbHrqgm41VZmQoOpvoGQkFIHr0bF+AE=
X-Received: by 2002:a05:701b:42c1:20b0:143:2984:6517 with SMTP id
 a92af1059eb24-14d33399ab2mr3673486c88.38.1790829509400; Wed, 30 Sep 2026
 21:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com> <20260928-work-unix-passpidfd-v3-7-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-7-532018a91b21@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 21:38:17 -0700
X-Gm-Features: AclHuK9QRXzI8_0z1Op0JTA9GMdarUQ2An_aAKGGaGQjZXyZBTeygagsSXiYtsM
Message-ID: <CAAVpQUCf9+shzzU_sar=GG=E=FGvGpvQaY3ErTgQatmB=kSZsg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] net: add SO_PEERPIDFD_THREAD to get a
 thread-specific pidfd
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:27=E2=80=AFAM Andrew Halaney <andrew@amutable.com=
> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> SO_PEERPIDFD hands out a pidfd for the thread-group that called
> connect() or socketpair(). Enable workloads such as the coredump server
> or a broker to get a pidfd of the specific thread that connected to the
> socket.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
