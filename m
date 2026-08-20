Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132142378D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224585; cv=none; b=rGb2R8mRJjZs15lUwFaUoiKKb4UrfyeeP3GLUujfmqqff8AmfXPgRfFMOUtHzRjyhZDXOmbURx31FWAYYaLa6p+IMzM+xPlzXEB6CkEyDOjlGpSe1ThB7UaWYNqiF7XSy98dBTVuR9+ZrlgceCkSJ3tAXiEb2eTl5pPnddBEOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224585; c=relaxed/simple;
	bh=q6HQq+I9dQfNzGlpu1zi7Sq070BAgcHm4FdYtiPdPBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnOPTDZ5TvS5zbDMILGJsSAVthBlbJ2spYl4l/DvgcabEdRWSCY+LKHCnZXGayuTnXgt6Yvta6uiBX6+gKpbHuxI2arwimViZtlxYvLJ+GM2sU5J/H64VqrfrQ7qj3RN6zTrRzt5lGLNxOIyEH6n/yPNwYqb0fuP/uI4ldccKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKbIN6Az; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKbIN6Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966001F00ACA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 11:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787224583;
	bh=q6HQq+I9dQfNzGlpu1zi7Sq070BAgcHm4FdYtiPdPBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iKbIN6AzmnoOXelz1e5RqMylL2FVAYbAleZQd9fDS1elv3HcihDHhly01ePPN/Wdu
	 3xmAeSL+M3l3Pz3YruKyXV1k+jZsC74IG4mn2REE1RIJznzuYerJTF8bpA1z6RASXn
	 ImqXqvRXMnHL92neafPHO3wrBjtpDEvJmk1y0QtTaNuuUFYEwrmCdKhRoTym7Jj0GX
	 f0vOeujMg7ZhlNR9tvYCjUWowKr0eZIv/Lcu8q/cXqw6+khtj64HCAt33wizcTQgEV
	 riVakOBUNOBxXpXAaYsk59trUk2pR5CinEX1Syith56qWKlylGHmvcYy8jOm8oil+h
	 G4PWu2xXeaAOg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a422090b2fso228282a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 04:16:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrp9YDYFH02JLj9t0C6Nuqt0qb+ZU/qeB8ofT6gG8W+I92YJPvelNUFMk/f1fyd73qR2Njj8Cai3mfVgnBz@vger.kernel.org
X-Gm-Message-State: AOJu0YzcW//sj1J7WvkZtWBw1GJCABOqfcxdsZuXyoU0bAbuMacpOgoG
	o0LNUEozaqGNwxveX2mHu3j9f4lDfHedfjZdB3DjZKkmB1/30FYamoG7SAbS0Zmu+0S8TFul0Kv
	GDpnhVVB5qecS7zbXKmQBu8BxcqXEim4=
X-Received: by 2002:a17:906:7949:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c242e22dc77mr863348166b.14.1787224582224; Thu, 20 Aug 2026
 04:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-fix-empty-mp-v2-1-5d3367048b76@gmail.com>
In-Reply-To: <20260820-fix-empty-mp-v2-1-5d3367048b76@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 20 Aug 2026 20:16:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Jp393dq5vBNW57gkF6m61Ov-s5Su86t1DSUo5zVZjxA@mail.gmail.com>
X-Gm-Features: AcwNN1XWy5tCl9IZmBwf9H6YcLXocngnzDD8PsgTJxw_rNLDaIjOjLD2tiTLPv8
Message-ID: <CAKYAXd8Jp393dq5vBNW57gkF6m61Ov-s5Su86t1DSUo5zVZjxA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: reject invalid empty mapping pairs
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Robert Morris <rtm@csail.mit.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:19=E2=80=AFAM Hyunchul Lee <hyc.lee@gmail.com> w=
rote:
>
> Reject an attribute with empty mapping pairs if it has inconsistent
> highest VCN and size.
>
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator=
")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/all/9519.1786907182@localhost/
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
