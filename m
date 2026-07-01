Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85983B1016;
	Wed,  1 Jul 2026 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891851; cv=none; b=AyLCKmVKyP1fyDJy6YKHYKxy2v9JdOmMOtiyLeI1Kiom5POqbqlmtSbp4PeESweGyE6eqqaZrFikgPguccuAbS9A9FJ/hVkMpk1ZOxvpyAY7EoH316wCDbypabpR6HvkfiFrpr7/8Pixq9A42NzuwUSjPRnrEZnXFzMirXuVlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891851; c=relaxed/simple;
	bh=MLHJ55u6fkpaD2Px1OJT5Ffy8FyDtBQJsFcLHSj4Oq8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QjaYcK3bvHMqHFFpyAnKI+aYswfTKNkWMrj4sdtoyNXsmx0JqS/fsOvk3zl0oLUYDKzpg/8FJKghWrubtmxU2E0H2aWYCKvoM0hyZ0Eyzr9xSWk9Kkfk4pAqsXKvo2SCjS7OTbWIYNZrWwTPdhF4loHmJ9lhGio3zxjeBqEbRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1uk3EQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1uk3EQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59181F000E9;
	Wed,  1 Jul 2026 07:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782891850;
	bh=MLHJ55u6fkpaD2Px1OJT5Ffy8FyDtBQJsFcLHSj4Oq8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=T1uk3EQZYvJhT0cMxWKx+q7GONtrv9fvk1of19IekudsERiTc08aBC62mVyzyj9IG
	 h7K2D9udhy3hN/rZhQ3jTohEirdlXfm7krp7PoruFREobPRj1a7MNjy1wdNwv7rE5W
	 o1zRz+6ruO7cAzKrnsWGlHq1yc2v2TPrJZpL5AX7cRw33yKKaMN2qwRwlAegXS6e5x
	 GxFCD7ADMlxE3Upoq3v46oIAXdlFGpO76KUsgt9PQdqIfdcFW5SBrkZ/2+hLza40xy
	 SzpVBrS1qe8kFMka90BdwmklkIWBNUQB5/bVrPxXZ0XRWXXNSyiCqSgoij4K567W4G
	 02OUx2Oc/942Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v3 3/5] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <158151977.3525022.1782821834050@kpc.webmail.kpnmail.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
 <20260629194327.2270798-4-jkoolstra@xs4all.nl>
 <20260630-getoppt-granit-gekrochen-78244e8979d9@brauner>
 <158151977.3525022.1782821834050@kpc.webmail.kpnmail.nl>
Date: Wed, 01 Jul 2026 09:44:05 +0200
Message-Id: <20260701-angezapft-unreflektiert-galant-e89d63be60ac@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=237; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MLHJ55u6fkpaD2Px1OJT5Ffy8FyDtBQJsFcLHSj4Oq8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5HHV/snTF+qDVDH9smy9veXglwEU2MZ5ZaWIxz33p0
 OPdCwSOdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk9hNGhksHM+wdVF++yryv
 7Z529r9KRoHClyTN9itpyrnLamav3cPwv7LM7e5OXYmTGmKzq53sA5wOzyg5ZpITlLHsbEtX0i5
 XLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> I also choose to not put -EPERM as sentinel as suggested first, but use the
> actual LSM error. Agreed?

Yes. We have to surface the actual error. In case the LSM is returning
some custom error (can easily happen from a bpf lsm).

