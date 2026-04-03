Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077922DAFDF
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239995; cv=pass; b=P248T9ahzc3ElfCWNjdp43MbYkzwuvvxFWd3COYVipeETKIZR5pkaTLfJNxLvJoTMnU39MmoESvzUU8yBdHv9+sHUPquqmhwDsl+UuwANj2oAkuByHGVy3OYCyN/i484Sdw4ABzt15RQ3hZN6mJdyPiKYkTogjF+IT0bNWQtgRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239995; c=relaxed/simple;
	bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmhbCYMjfzMNLYN3IVvXv4vZsYxz1YWNejf1QdMjlXplS23E6mIQ8HO69XcyP2ao4qF3RDdHS5cEp6oVtT1OYoQfkv3BFKfZkkN0puEtrFoudcDb/anJKnbERw/cX/p1O3vCawT7IbtsAiki2/XefE6SBNK7AX1NRXi0W6XFjy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GVvl531T; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GVvl531T"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9c04152730so322326366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 11:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775239992; cv=none;
        d=google.com; s=arc-20240605;
        b=GmWe32dmov4d7wsDaAHaSK8V9e1y06yyjr5kfUoRjEVeqTKeYaLKAAK6imUzIE1aBZ
         PEHiIh24XvdEavz0aEdlo429W7CauWhPgQT4g3FFB5lV6Pj1SsBwic13cwrFrGrvx7tW
         ELQRZDl40qy0uxvGXFvJbcoqPoPgpb4xPxXskGadzd0ZZVdIInvIQLLV6XXNpqhX0xZG
         08z2gAjr83wdI22GYYpSzMmx7/tNW7YqYB7lgON3oH1WXS7QH4ZgIxPmS90rLcGASjOL
         YhPtisNfmfxDUs+2vsmCRonZq32gPzypG59mjQOt9bXSDtJ8SJcTe+wWtSMoKQOtYFZs
         vhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
        fh=CUOg14A40vuC/KZ/b0B7W+7XPuSwYc+ZjcGqeXIiZyM=;
        b=GvnQ28l0hX7QL16AL6AfNr8FN42GkPfQXV/2OCkv2fIEywJhiTNom9Q0I8J4tcrRNY
         9qZS+32ihJDro0+3e3d/Qwey5MvN9MSFOsJKYMRxh5NCV3ghVao+M9olsbbgI3KjW39y
         qaE6y3z569x7Z7hO5JgqDBu+Z97THv/vDeqT/ZTpG68s+EiMb+q7TjFgBepNDCgTDgPq
         RYQanciceG/Z9D7YMlrMZKdw+PiZnqsBgdMRZsYntGNsyx5AfYOiviX5yir+26IP8oAW
         llEyaFCUi+XcmL8cv6i/l+lUu4t/KjD7nEObrkVg6WhxVjvucTUQZN9VBoXhy/EIYL2k
         Wr9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775239992; x=1775844792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
        b=GVvl531TxMUOKpb0vNb+9XWD54gbzLa8iMX9bcfWNLMvhKREOiQUmVoaGUy7VTkiSq
         U5qsESEgWGha73syRHIBhBjUjm0fcmyEyviElh5OB0Id2v/2NW8I+2iA5jrmoQv4jkdx
         LNH9xl/kOIQAoOzOmZgTzeX285myu8rzd36mJd2DX/LJPt5Z40Q1HgEap3nrqwQIWwkH
         PEQ7sgKqb+Kz5TKrykDt1pQ4E5s//1gwc7pPA6FaJWnsFmBGFAey+saFHCJwzFFMhTfQ
         kc+qHL4vjYfW/5PXA0yL3EPSHJB3EFUFcwXQ/N3dM9xwevJCTZ5dZZKIU7yJOtYo1nfu
         VuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239992; x=1775844792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ElB7ZuZLzGIcWqd5VRRtQQIBNNObowpCHWvdAYEp0Ls=;
        b=owz6xNVr1Az/q5WaMYJns8gToL8mGfgCv6Zm/Fx8zGNjlz19k1KcwUO47KroDEtI4h
         qXz5Sb+ZuRho5bSBAv1WpnzGb2OCr3gbCywfBfOLsQRNHNB/D7b3DHd3e2yRDBHzE0cb
         rDwFBpUr/gRedD3zuHggIMCzJvGb1aeb6aAfKXcfY8/afhxDtkilZtVxRgXM/BsFf5ag
         p2Gntyl+FwJrsVMMVgCHFPBgKIXmYzCATVXlg5jiiLZ5gAHfECTIBP2j9QHjyaFQF9DB
         gOBqiUEAmyl/peQC+GwSuKhcvCvK8cZ2ChkuWeYnMkWaxjXH5pmjYfnQxUZ5QRoJFnT+
         11aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3HQkwQgqsFXQcbVnYG3aN23haOg2qOOoT1DGr32r32a+BmTBQpnHjGIj6978ewcMCfJ4EwAdKVaR6m37f@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCLyNV2SGFjm5pgmF6sk73NsjyFh0r9uH9Hn9Niv6j6gn7l1N
	Wt6TrJfltY2/WQq8js6rousxFXPvNQ0kSDS+fDDjAgKfds3Mw1mtEyMTYBtqhN3n8mEHMkKwm4w
	fUvUKq2sz8fVE37GwLRI9o4Xo2Ng1DuGPdpdrHWoopw==
X-Gm-Gg: AeBDieusRY3t08dqhI+Wbf80h1fJ+ix4Frtp382xmE928f/vKmtNofjEjnd8VkkbteY
	jJrF35lP4jVkagIfNwfKnpAsKc0mDg+KniPu9GuI4xD5xgYEmqhjNqArdy1ewDa/Qs1duvhO0jz
	lbEP5NyindBsbvGJBr3WHOJrUv45Z0R7JwGs83jEqpJLMhk3ogqojJ9ySEqptscrEDz/y6f1H5g
	xYkx0jthLcjZQvlFifvddM/Ls0IGr/PjMYTy3o3NmuDrXHRfIOOdk5Q2HH8kXEw24JgHKwZToMS
	gYiIJlqdKh1NfM4svs0rRduxKdWlkms1i9C0
X-Received: by 2002:a17:907:c002:b0:b97:f22f:43c3 with SMTP id
 a640c23a62f3a-b9c67951924mr190315866b.31.1775239992468; Fri, 03 Apr 2026
 11:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401205613.2095623-1-max.kellermann@ionos.com>
 <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
 <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com> <ff8929f3cc1ceb1fef43f292c9c5926a25d8336a.camel@redhat.com>
In-Reply-To: <ff8929f3cc1ceb1fef43f292c9c5926a25d8336a.camel@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 3 Apr 2026 20:13:01 +0200
X-Gm-Features: AQROBzCml0wejgS8KWhp_lEvInrGoAcd3uhJWZZ3HEky3MQRfu_mu4yL7bGyHI4
Message-ID: <CAKPOu+_ghf7cw8zT2K-hyKhdWiFaQss2jFQ-JsUUPBU0MmSFfQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 7:18=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat.=
com> wrote:
> Why the offset is not good enough?

Because the "offset" variable tracks the whole write, including the
folios that are supposed to be omitted from the fscache.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
