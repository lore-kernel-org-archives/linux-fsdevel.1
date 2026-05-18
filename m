Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC23E172E
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103248; cv=none; b=iauDgFn0G4WEpnmpY5DI7F3WrR2IMsM8BG0PLCOQ/XG40DDzYvLFlQJBnxKeM9KZrT401GerYKrn6XFUO4ChxmM7hThmX5Ae8ArhW74LlK9YQM3VBi7+/64QUNXSlUBXEEDcX58lpfojv+TRZoibIrBtJNZryi+8P9JxqcEdRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103248; c=relaxed/simple;
	bh=HoKzj64lrpg7Nn9WRt+NRUHi4m0teUM6ZEQhbCQkCOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAgnmiRgJTjIJGEDuyQZ3E3Nkkz8P9NejwERyiFSu5zeSzl+04pe3B93iWnm+XodbmzdGMz/BoDIeY5cV+ApmeQNjNJRltHfVxTYcL67Eq/pYb/sK8B/7QYGSAIVL4D0c2JwVDmeoIhHRp6Odmts21Pr+nvvHtSpWsBi+GSyHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4jb3MzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4jb3MzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2066C2BCB8
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779103246;
	bh=HoKzj64lrpg7Nn9WRt+NRUHi4m0teUM6ZEQhbCQkCOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i4jb3MzQvQ7o234KLPxlob6fwnZ2Yiao7Wa4hXrN5YW0kZ/ycXIfXz+rYr9lPabnM
	 iTeLrvDjr5/qNjoXKHbpdN9wfMYTDm1OZiAnQapMySyoq87erS7LBK3aDNpLgP+/7B
	 ATPfp5y1jGIZTG3ll4TwpNnER3BbHm7YgN9DEOUTDKuZVPWLOEkU5Ozz00DoNzxWTG
	 fWilfKQGBGuuBAX1qngaBzpUkFwH2XsAzN05GDkenkm/OMQSKhANBkZIR35xH4tV5r
	 Y/V2CxuUIQWMtOfFRAVjJmSGyfnKCnjD2haVaF2tLCtqB/G/WX6AcHakfFvc5f/JrO
	 sFxaWInrQ7z8A==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd2e8931915so508982766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 04:20:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ZSogF9i63uy0sEngWZNPlwwUVKKnQQhgRfTOrQ0QjnkPjcIosriesc/VuExx4kCUZaRhKaf7mr5q1UYNe@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSrSqCeBAHwmOMBEKX4/0jI40vAGcCLrITd3M9stEg3AG7lse
	prpIeBhPZsu1zmPaIXSXSgRKAQoEceQELh61HGwlW3f6kYzBa+h8+LCxH8Dt69pibgRoVAXCru9
	HpoCd5I3kGN7tjSTeCZUZQOVQNyOZdwI=
X-Received: by 2002:a17:907:9627:b0:bd3:7514:14f3 with SMTP id
 a640c23a62f3a-bd4f333f84bmr967482466b.11.1779103245156; Mon, 18 May 2026
 04:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517034447.1330941-1-charsyam@gmail.com>
In-Reply-To: <20260517034447.1330941-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 18 May 2026 20:20:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9F+nLwJOWy2dtduLSmPrwq6XYWvKLfgmzXn09L5mt10w@mail.gmail.com>
X-Gm-Features: AVHnY4Ljs7W81FH1o7y8I2R9RjR2Xgus51B3cQTicTeiMKbsY4hnlclvsz3ZOvg
Message-ID: <CAKYAXd9F+nLwJOWy2dtduLSmPrwq6XYWvKLfgmzXn09L5mt10w@mail.gmail.com>
Subject: Re: [PATCH] ntfs: remove unsupported quota handling
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 12:44=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com>=
 wrote:
>
> The ntfs driver does not implement quota accounting.  It creates
> new inodes with the NTFS 1.2 $STANDARD_INFORMATION layout and does
> not maintain the NTFS 3.x owner_id/quota_charged fields or the
> $Quota usage records that Windows would need for meaningful quota
> accounting.
>
> The only runtime quota path left in the driver is the remount-rw
> code that tries to mark $Quota/$Q out of date, plus the mount-time
> code that loads $Quota and its $Q index solely to support that
> marker.
>
> Since the driver does not maintain the per-file quota metadata,
> setting QUOTA_FLAG_OUT_OF_DATE does not make the quota state
> meaningful, and failures in this unsupported path can unnecessarily
> block remount-rw or force a mount read-only.
>
> Remove the quota marker, the $Quota/$Q loading state, and the
> unused quota volume flag.  Keep the on-disk quota layout definitions
> in layout.h so the documented NTFS structures remain available.
>
> Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
> Link: https://lore.kernel.org/all/CANFS6bYTzioqZjYt=3D51Kb9RdR3MKXaez_fh_=
WCLoym093VxFmg@mail.gmail.com/
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next.
Thanks!
