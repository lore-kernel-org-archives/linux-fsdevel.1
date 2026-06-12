Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7C37F8CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292634; cv=none; b=K7L8miR0gNTdZzojjZ40EY9x7yTY235/UMwpqJLNQ4jr05fC0F3mVVmJZ/Wz+H4GOCporWd2J5NsgipPvN4qV9qAzG4LnxrA3QboT2zbcQeGOmpM5/JNQveuxz41lvJmBlYRGsJHz4aeWjEzcCkqbtrhJpxwKONBbvqf4u0Cuj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292634; c=relaxed/simple;
	bh=8B55g2vnmCC7cvkYzifw47xrkf+YeePYVbnYldCHNEk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRzIfljxnjmKeMfjuMUEx6TkQ0hXVgmDn7Ln7IcELWeWAMMTq3OASlW7wn5fxmwwNryjf0BZRGXkAVFbbGCN6SYY7/JAM67mwS0M/ck7AU0w1Owrq7UZBkFRVgh/Xd/O14fbfI780ZPDj5NxZ8hcG7oZH2wQYPhWmwni1FYJsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RbPL2OLT; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RbPL2OLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781292622; x=1781551822;
	bh=8B55g2vnmCC7cvkYzifw47xrkf+YeePYVbnYldCHNEk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RbPL2OLT1F5CugtGeyJVrJ9WGlSeUCLG1UNmQCZqTprUsE4e+ABaCBAc6v/8zElLy
	 /xJLh24ZZ6wBuA7iQpLBQg0m5bf4R5Jt3jSp0ihWX8qzhY7LIuj6iEfIpc8DA5tH0A
	 WDXa+dTSRzTNMqU8lOoJXx3T7Cbe+ZhO8v3iX42Wc/6DRoGS5Hp9GU8NQ6EWy8hYTW
	 gSC3gicDmsEisimJXnMkRYlql98KTr7DlDbFCvAiqrlP27hA+Zivu1gazYb7OTvL0n
	 i1F+pO9zBZKq9McjWpsLKZg8y9ABMqUD8KcJtNH2xPa1vxcr+5YbqpcdDvTw4zs3q3
	 bKhMjostDTv8g==
Date: Fri, 12 Jun 2026 19:30:16 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: bound uniname advance in exfat_find_dir_entry()
Message-ID: <20260612193010.23238-1-hexlabsecurity@proton.me>
In-Reply-To: <CAKYAXd8OEYeqVfKFyHR6kLJdLvfcfsdUSsNfXB-j93JyARJhNg@mail.gmail.com>
References: <20260611-b4-disp-c0e7d249-v1-1-7f517046abd7@proton.me> <CAKYAXd8OEYeqVfKFyHR6kLJdLvfcfsdUSsNfXB-j93JyARJhNg@mail.gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: eb60937d7e6045032acc28b667fa63d01ed0dbfc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

You're right -- by the time the check runs, uniname has already been advanc=
ed
by the previous iterations, so `uniname + len` forms a pointer past the end=
 of
p_uniname->name[] (undefined behavior; the compiler is free to drop the che=
ck).
Bounding the integer offset before the pointer is formed is the correct fix=
.

v2 uses your form -- compute offset =3D (++order - 2) * EXFAT_FILE_NAME_LEN=
, reject
when offset > MAX_NAME_LENGTH || len > MAX_NAME_LENGTH - offset, and only t=
hen set
uniname =3D p_uniname->name + offset. Carried as Suggested-by: you.

I re-ran the KASAN repro with your version on the same crafted image (high
SecondaryCount of all-NUL name entries): the bound now rejects the walk at
order 20 (offset 270 > 255) before any out-of-bounds pointer is formed, the
lookup returns -ENOENT, and there is no KASAN report. A legitimate 255-char=
acter
name (17 * 15) still resolves -- offset reaches 240 on the last entry, len =
15,
240 + 15 =3D 255, within bounds.

Posted as v2: https://lore.kernel.org/all/20260612-b4-disp-d3abc2b6-v2-1-93=
ec15095270@proton.me/

