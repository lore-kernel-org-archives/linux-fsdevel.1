Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5323090E8;
	Sat,  1 Aug 2026 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785552788; cv=pass; b=tW01MMcgkJvtgRMM2hp4kVgmksQWY95PQ97M2ArAJ3ooVHka6V3Fob1mO6bJK0fxDe1zy9J7d/u0DyHdsepuCI9sXfhns4Us8dKs6HebFnEUneRyCmN2ykUAGpdSdgf0VXrGF+CIOOcCz0GDUSZoMPYl7b5ir8ZOzHBOjPpRU/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785552788; c=relaxed/simple;
	bh=RQcBUH7xcDtRJslCKK3KM8ssKlJOCSn0mO1gJ5p+ZOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiZ3r8PULVo5oEKaozxk6xtDLvRJ0d0NToKAF0GiQAAi1qCKLI8y9D640pqpBrLBiE3jmbXyTfvgHkQfIz3SBSjXaIA++MBN+7jYvBcfnBULrUSQvrYe+BGxpO7gcC77b8UuS8frBzivXfAu8esehf0TTGqECsxlQ9WjTt3PJtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=RUsoN9lo; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="RUsoN9lo"
ARC-Seal: i=1; a=rsa-sha256; t=1785552765; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=INODdLqPPWBn7FwuH9elD+yLRI8jstBiwkPVkFzq1lbVF+d4GtzCWf4Lj34p4TdR1zmrqfIjprcgZaW8KwYU5gWk1DIWWg8yxAXwHf0zcHZjYmSbS0W04kWoV3iPaIwLsaygAoAZVfT4gbshYn8ywGkh1u2bc5jj9as1ciLXrNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785552765; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RQcBUH7xcDtRJslCKK3KM8ssKlJOCSn0mO1gJ5p+ZOc=; 
	b=V/CJmlkfGLAibpeERdN7bpQKG78p8JEYC+knQZWeYFjxyn6aEEAjvpvVhFD5gGEGqVTnlHor/akskGyFA4Lo6qzKYBDwR/U0IQ+gGLRjwjvNuVO7/VX3QDEJBx6aVpYWbXGI9FV+URieLF2C9i4+ruxi1lbTV6ZojJsP331vVrM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785552765;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RQcBUH7xcDtRJslCKK3KM8ssKlJOCSn0mO1gJ5p+ZOc=;
	b=RUsoN9loAg+RUkSSJKqxXotDwYF1tk4eXZWwJxSFKaoW4mayl2fBms7xpUHunoYP
	YcKjjqoQnImrUK8pZZ68JH/NUUJxjtYLc2ycYvfTA5KhrsXqVBsrgQ/mfdIKzzjziKD
	LHVP55nzu4/5Id9C6L5q19xCn5qStMO2vLlLa9OE=
Received: by mx.zoho.eu with SMTPS id 1785552763180616.7476242942278;
	Sat, 1 Aug 2026 04:52:43 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: David Lee <david.lee@trailofbits.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs: reject oversized cylinder group metadata
Date: Sat,  1 Aug 2026 05:52:33 +0300
Message-ID: <20260801025233.14590-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717104033.38574-1-david.lee@trailofbits.com>
References: <20260717104033.38574-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

I traced the count assignment this patch protects. ufs_read_cylinder()
in fs/ufs/cylinder.c sets UCPI_UBH(ucpi)->count directly from
s_cgsize >> s_blocksize_bits and then stores into bh[i] in a loop, so it
does not go through the UFS_MAXFRAG clamp that _ubh_bread_() and
ubh_bread_uspi() apply in fs/ufs/util.c. An oversized fs_cgsize
therefore does drive buffer-head stores past the fixed eight entry array
in struct ufs_cg_private_info, as the changelog says.

The new bound is sufficient. ufs_fill_super() already rejects a
filesystem whose s_bsize over s_fsize ratio is larger than eight, so
once s_cgsize is held at or below s_bsize the derived count stays at or
under UFS_MAXFRAG and the bh[] loop is in range. Rejecting a zero sized
cylinder group at the same point is a sensible guard as well.

Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
