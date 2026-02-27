Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48D2D73AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185632; cv=none; b=IGAHbjXFbsKAkDHSXnMogjWSx5gG/2Ysuq5ZoVzS2J90oP30sLD9OTM9j9lgvf6IuNrD3n/tS78bEyG0VTYMzG0Pzpj7+4jfMGBbce9faxO6Uebj7VWt5YHdsw6sL4kEP1jRtVwGrbQ+Sw5jb3hBFCk6CFvYOtZ6uFcYbC2YDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185632; c=relaxed/simple;
	bh=k4BeZIjRmkzX90kzPP4CZI2hlwEyDJIy7DWLZA2KY3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx7BIRlc1i/SEarNHtfjurEKrKZ1cGiuTw7or9ugGP8FWF2da3gwx6PGyrDMuTIZOjMf0F6guTSnZdYKzl9GxnOIbu/0SaMfO0D0KFfDcvxg/Lj9pytd0GdTNHAXj9ng2jeM6vR+tmI1Fuj2pidMzgl1B6Rs1XHL45vGeI4oRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBF+iDIi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBF+iDIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D31C2BC86
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772185632;
	bh=k4BeZIjRmkzX90kzPP4CZI2hlwEyDJIy7DWLZA2KY3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uBF+iDIic1st4Ks1XN36Z1nsikS9bEM07PwLw11YdCgwZApbyKw5I+yt7R6MI3sKD
	 UJdQR6AJkijbqcj/eCFMpvwdOWECZxCSs3Vz0NSJjcH1wU3LLGA3fu/rhit9misbvY
	 i33TmU7l7TuciROm9L01FwkWYlcDG3Zxa8ZhwlIaGsRUBlMyh5lwK+6yEgUWtVmf6P
	 aHdbMasyKOkH6Ve2P5GDAPF92vwzU+rX3J3yR6Pl7Yy13Pzvu1LmxxFtCpRLP3vgBh
	 9dQCi0fAkGeQK5/lKZQ2erKVs9w2dT/jOjJTGLyDl08IVAJkAEYE/ZKfXo7Ok1wRcM
	 MuOBV1yIYLUMQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65f767a8d62so3650831a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 01:47:12 -0800 (PST)
X-Gm-Message-State: AOJu0YzOvj5udnJFVJCqzjoMJFe4ozPU/CJkMVV7Fm3meQuJR3wbyXwg
	3dlP+ST+VZhmSt3Blb8MsDoiZaEisjRvBQKy+1aC6oxciXtMLXB79q8j1tZsoYlaItCeVvm3QH9
	mkd94WvEfwLVK49/WsmtgBj9kvDNnnPs=
X-Received: by 2002:a17:907:3d52:b0:b88:587f:f594 with SMTP id
 a640c23a62f3a-b93763a63aemr131768166b.18.1772185630698; Fri, 27 Feb 2026
 01:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaFOvvCNNEsDXXBT@stanley.mountain>
In-Reply-To: <aaFOvvCNNEsDXXBT@stanley.mountain>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 27 Feb 2026 18:46:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-j-7n6ht3P2F0jci=JjkMRhNiMKZ9rFV4qmr0Byr5s0w@mail.gmail.com>
X-Gm-Features: AaiRm53xnS3r2jrhPDM24rJFhgT591IjZnVMuPXSSR_JYdvaMlP2kDnlQvvZhdA
Message-ID: <CAKYAXd-j-7n6ht3P2F0jci=JjkMRhNiMKZ9rFV4qmr0Byr5s0w@mail.gmail.com>
Subject: Re: [bug report] ntfs: update attrib operations
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 4:59=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> [ Smatch checking is paused while we raise funding. #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
>
> Hello Namjae Jeon,
Hi Dan,
>
> Commit 495e90fa3348 ("ntfs: update attrib operations") from Feb 13,
> 2026 (linux-next), leads to the following Smatch static checker
> warning:
>
>         fs/ntfs/attrib.c:5197 ntfs_non_resident_attr_collapse_range()
>         warn: inconsistent returns '&ni->runlist.lock'.
Ethan sent the patch for this and I just applied it.
Thanks for your report!
