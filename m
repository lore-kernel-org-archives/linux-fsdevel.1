Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794557277;
	b=enmTrQ929T7KaMaIx/QjLGRwTgQ2Fndrq1eS0IBwXAyUVexplNZlq8WLSRsksNPd/eni
	 3nRqZgoLgVoXw4qIP3gDvzaPReE296onPQFViogMcaNyIyVJINNezQ9kHgULVNrbEsq8G
	 fvOUdDp17piSIIQ3XDNKGZy8pgh6Cmuh9oAcMCt+rjDHkMBPP6Ew0fJ8v1WWLmmPTmDEV
	 X3CYnYqDe1HwgjAKX03BoUIYS0oXFC3cXqRueTvYFNqQ2BNyycscb/VqeXgWUose+AMaU
	 7rKX7WHu7ZcMBJoW31qbs6dlYxacMAD3b9u+r/f7sPaBKuCGzCeqbDmP30B6msoyrcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RJeDyy2z7kkHFWLo9C+DbCGPGNpT15WcYw9vAIT2GC8=;
	b=RHJg8iEXMd0Cyp6soVSk4axoHHTmHCt/nzOj0EDetGlGbsKUR6n2p0WvBZ27La988hNH
	 Co42psm9v8MxS2RI91475cDnUZ37/9KJE+OAzMlxm0qHtYjis94odp/YSfof0A6xxwpeH
	 SR7h5f8eNOngpu/SKKg4xFirqafI5VrZ4iG8ivcNupBzlovwB2H4J1HvkUCuYh9iUsHGq
	 W1aWV3ax+hy6mDvpMo1k/2P3c5TdOgSIeEjRUPTy0yKAE9tf+P6jzWTllEqv3onOO87UY
	 cOVWKnTE0DRGWhT56wsC8fr4ZNrhCRzolhMv+BWxvTYcqcBaObsfAaBSoGga+LUWAmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=QH6Jarga;
	arc=fail smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22079606A32E
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 08:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22079606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=QH6Jarga
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c169ae1cb26so143178366b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 00:07:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794557275; cv=none;
        d=google.com; s=arc-20260327;
        b=dpKcUw8sL3snvO0Yp8w5aYJ+zBdxEWxq2kKp15y5lvjVsUcclHjPndUzckDuNdiY91
         cq+qzRzfcXNTh+Plvb9ITP7jjKK3XjvQm7GGJdose2ndDJXNdpsnUifylqZ4poNDWN7p
         Q3exUDxDoxbpzKqyLSyMetZQOsJiY+nHWLobzysNJ4so05VIkyPc9X5vhKGn9cOyESii
         ZMMUgO1ScnMLqetMzrY70BpI5ewxIMmEsly7JrcZdJ6gPlu/l/yvNCNE3zSxhi2sxwxc
         WUEaRyphSxF4iwcqJHxbRPd8z7b2ANShMzqcIbANXbpM0d2JWy7Z1eHEHnt0ARK3dRHF
         rM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RJeDyy2z7kkHFWLo9C+DbCGPGNpT15WcYw9vAIT2GC8=;
        fh=ixnBgc2r51Bqmgx4sEaLx7gHRw0rLDOcpq7HoYg9sRk=;
        b=d2mEsaN/Eas7xEW/jlBTd8On9V/JvsUlhEidirXfn1VHvBMWY3h4t3dSG4iPJjPleY
         nBX3GagRbJFRvu22iRKutvNs9ZWHtkGkyXcB0oyWy5/bQ/qnG65rOdFGl6r4QqBOFors
         YXhMPX+nofzOatL0lA/fbb2xvYF6lfal3/GtnSfnJZiJVPdSaHANjR3iYLiUiVCD60bx
         x+piBN3REjKfJrKwNECn2iLANNml1yYYwJl0F2yZllSbnZhiKpJSA/GzOCFB1DEKljJ+
         W59/B1zKU9SZS+n0rlu/jFrppNV/a+iBgWt6duo4+lgmRoYb9EgR1ij0ymVi293T2qBW
         GCCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794557275; x=1795162075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RJeDyy2z7kkHFWLo9C+DbCGPGNpT15WcYw9vAIT2GC8=;
        b=QH6JargaMxC4CdhJPH4dsQNGCIbw4+vTz+kGh9LSh3mPAtUV4bfoo/2GVax3xGeHNU
         ouD9UL51e9WWuR/E6DWrHmndvAzJDQnCs7mspeAPBuhiyvMFai+Ll8X7VRj7l1lJOjaV
         xdQrIhCwSBuj4WCyai9Ob5f+E5797mfoySukKn68nUMPGNy0LQwvznlritJqc7ncFkyz
         ZGxCGLSon9hJmrv88rXn7z712MRY5b2uDxfcSnK5yDnBla6Fmn345Ue0LzraJX3Jzfmf
         /4zQ9Pb2n6mDG0JuA6ylzkOsT6G5ATn1etq8WdsuKDMEArebn3rqaZXe/9DRZAhl9ne3
         FQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794557275; x=1795162075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJeDyy2z7kkHFWLo9C+DbCGPGNpT15WcYw9vAIT2GC8=;
        b=NAKAmWTUGMitRdssRlQodgcP0W8jlv9QIbdG0myOd/OPlG33nreCtW86wx+oMrhyDx
         yZzVBRoZOA967w5pRJJ78QsvukgZlUt5OkyCv2PpIAj848/jFICQP4vSTqJnTkOCMapX
         7/tS14+2OZdHKhxo/axt/BnxlI6K42e/wEhvKBzd/QMBFc2Wt+X2T4hsmlhIaWziWyIx
         0mK4OkCjxanWfYqA/ksF1kMxuXz66SYrJ9Lp96062CqwTdkHe58DQvDY2k0wIMrrxUB/
         yZfowpIqnZ3Z4kgR9vxdNx2rR2/JtPRXGCvg+l0g27nq2X5iEbcYQ9JdMXOkXavDg8tx
         o61g==
X-Forwarded-Encrypted: i=1; AL+hErFwjUsXIuyydekvXl+CKlGZtMlPwPemTLizBBvk+ArpVvrjTyzUUJaD8S/a20bVCbJuWe2cETu9on93w257@vger.kernel.org
X-Gm-Message-State: APuU4Z+TPup+gCw29YuRUZqOwEyGCX5YRUD6QQnhTSojqDatvNy0JW2X
	aCYRNGt/WIUvlVkj3n7T7VPzoonZvX9z0SjHJ2uQ0PmRApsGBJ9wrh8XQNJDgzbB/BBpc7goFZG
	hYhYOPwQsqkCYcMdynPNc9dii74DnihdkvAhjMzmjdw==
X-Gm-Gg: AYBFou2EVwUecVYf02e57pxYiQjr8/nHgXe1wico4KA6XBh1X86h+JgefCpzuqnGSIo
	1s4mlatYOQsyZCHMLrMoumerz7nScRgQDxPBjKkQS0j6jJhG8Y23D345X/l15ad3YsTQD0K3SvD
	Pimrs4EC5s0HD7sd0aPL4pYxnoUBNmkHDAVOitmVPw3rHzhoy9yCjTm69sWRg7qBMX+4j3yYyz/
	XkKoqvyyBeygD1LHDpTVcBAu0nlfAYztg6etps9dZzhkGqT11qApGtXGxJlerCP8DitomsbH9Vc
	zAUK+UrHSDSwpXvlDoOCdIkFWR59SGVBkBlaJRaFl3wizRTa/Ys3l42z0lgboljneaGAgxJCqB0
	lIyFhREw1bi+9Cg245TQNheheWREqcmcK7XDN3LwtKbejdZWn0ZLl2S8ZMoXTB7F3j8wCGa/4ty
	evELYtXD4BVKs=
X-Received: by 2002:a17:907:2d14:b0:c46:9711:e30e with SMTP id
 a640c23a62f3a-c507c46b13cmr451895266b.29.1794557275408; Fri, 13 Nov 2026
 00:07:55 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111153631.1309838-1-max.kellermann@ionos.com> <mvh4ekf6iyfijuqggxhpl7kwxdyysx2zqdrp65bxitucxikwpm@6bkppgjyhsoj>
In-Reply-To: <mvh4ekf6iyfijuqggxhpl7kwxdyysx2zqdrp65bxitucxikwpm@6bkppgjyhsoj>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 13 Nov 2026 09:07:44 +0100
X-Gm-Features: AclHuK9zR7kzmKYvs_047uhc-z1BRlEn56R2GSk6_IjDFBx3cCWd0_4I6VnEDCo
Message-ID: <CAKPOu+91dBHnssGbHRi2BhwLPU_aoR71Bybh2ddGHeg_G=j4rg@mail.gmail.com>
Subject: Re: [PATCH] fs: pack fields `i_state` and `i_fsnotify_mask`
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 7:38=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> When moving i_fsnotify_mask please move it along with i_fsnotify_marks. I=
t
> should better be in the same cacheline because these two are accessed on
> some performance sensitive paths.

Tried that, but:

        struct inode_state_flags   i_state;              /*   120     4 */
        __u32                      i_fsnotify_mask;      /*   124     4 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct fsnotify_mark_connector * i_fsnotify_marks; /*   128     8 *=
/

The cacheline happened to end after "i_state" (and now
"i_fsnotify_mask"). I could move "i_state" down instead, or move other
fields around - but you're a better expert here, please advise what
you believe is best.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
