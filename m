Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250939AD33
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748778; cv=none; b=JUN4KGsdhOGi0Ig8Va2IB3w7V9qhRnnu2Tl+lj7BHlvVyswkuI8yj8tGDfh64q2mWhaJaExQxeuL66l+tGHKHOL1/LJ0Xe+KFYdtWYIoittRSJLRUIs0aPJ3bOsSX0XI6FqM59zxgqlmibSN9jh10t0bWE/DkG5OZxgSuDo9Krg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748778; c=relaxed/simple;
	bh=Sx5uRKbJAWrpHbk4G+Heq6JXqNc2Fx/dHMM/ldJ/uIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPZdh/lb9aWfmudOARX4fT3miXlnUSVOdFLWwBBiJkl3ujKH0JWl4De9E5MMT1jlZaPHD2kZS2pygvQm1gTahBroXh7ywR+JG99xlDjQ2w/BP9d4279fl/E7Qp8lOyFP5bYSIFWKg5BYM8WgSfZowMPCPpmGfxri+ujWH64ci2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y64vaCke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y64vaCke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248761F0089E
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748777;
	bh=Sx5uRKbJAWrpHbk4G+Heq6JXqNc2Fx/dHMM/ldJ/uIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y64vaCke9LESWootzpP7pmk1OxsI/qqsuXJcZgXtcjLEcxP7GBFYPFk1y2ENnelIs
	 +RFucPOhHSwaSY0P+nr1qlbyAXaBqRLF6kc60O6sPb5zhVf4FaswHv/JdACFKmXIdL
	 YLerP/vPWyd8m0+GBRJ/fJfGfRyYZEU5Dlg0IAbWAPU28nqVAFUFWDWKpjHpefm3YW
	 5eQnXvzm5JKwB7cnFel2j1V33Q7KDZS19DuxjwYdEk8sKCwfA+68l/mVq4vG8jlxPg
	 PYXHzeWNK8TK0WDXWKGlyaVCmWEESOTqm1ACoHCq4p+BlyXChUSnsyP8tE2W2NcrL8
	 nY0WvTdZU2G4A==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec3f69d343so418847766b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 05:26:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YxmKjV6gjBdpNVQF0qEAn/WIq11GTh9ZztR49TZj6CXdteFGyNr
	xEMh109En0wMRCZJ+uH6TbMcXYNWO0CuFnltE9uErXUXUffmECKfXyOuqtpNqsB0Bta51DMmpkf
	2QQ6hyPaWwFrg+1CBsnXKvVp3exLzg2Y=
X-Received: by 2002:a17:907:d045:b0:bed:d329:1ed9 with SMTP id
 a640c23a62f3a-bf37283ced8mr397839566b.33.1780748775785; Sat, 06 Jun 2026
 05:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk> <20260606064956.2722874-6-viro@zeniv.linux.org.uk>
In-Reply-To: <20260606064956.2722874-6-viro@zeniv.linux.org.uk>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 6 Jun 2026 21:26:03 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8HYGvh-cbkE4Gi+ud7Oen6AQtMRy=HR1hhzwbqRRRHag@mail.gmail.com>
X-Gm-Features: AVVi8CdCjHc39AuzVuqFdOlSPpqHYSgU2Ec-cAQKNy182yc-rTXXvUjUaep6O_g
Message-ID: <CAKYAXd8HYGvh-cbkE4Gi+ud7Oen6AQtMRy=HR1hhzwbqRRRHag@mail.gmail.com>
Subject: Re: [PATCH 5/6] ntfs: use d_splice_alias() for ->lookup() return value
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 3:50=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
