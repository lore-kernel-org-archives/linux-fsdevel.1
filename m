Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CF2773F0
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633859; cv=none; b=eq8pML88CfxhaCd/AusILvPFcMXh47KOQ6N4jheGBLAuFgpf7EnXUmEnqiV8wv//dttSx4S8NrB36TWey6j75pve4n9REmmdcJWNseRVC6r8fh3HBQ7yLzXRTYdAasrUpzQMP/IjcJQrrpeB0e59nMeodAKf7gZcSBweaWnnbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633859; c=relaxed/simple;
	bh=Ia9ieiHgO9RG+3Mu209QUk1xEt/KTs3pKH88Fs5WXbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQggwQEnSpP9fxOI6zcGpbXg7WLO8h11Au5O79BF7aZkGHp0faubNcTQuVmQhGM5Lxydro/4PTxT1H242rLj/p63z557hKs7mkmJhOut0EbhmNk6rFDrEHueBciMRNmK6qEwdOoxiv2UAifX0wKJ42O1w3+xG52MDk/DwNzH/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=lQLc0qZW; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="lQLc0qZW"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 14D391D490;
	Wed,  4 Mar 2026 14:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 14D391D490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772633851; bh=Ia9ieiHgO9RG+3Mu209QUk1xEt/KTs3pKH88Fs5WXbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQLc0qZWF5rn4H8CYEXuaTcr0Kq7zqgKlvB55FyXHn070+VUe17pcGzN6jAKikLC0
	 cEo2OCYUcWJKkSlQGiWfOHgw2ufQ/HPw3NQvbMwzoifha+otWL/sxBVlQqaPZm9PLC
	 3jdINUtGUddLPZOuPdRPScHdqiGaU0JG5ZQCXVFk=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id ZxyOLvk+qGnLtgEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 04 Mar 2026 14:17:29 +0000
From: David Timber <dxdt@dev.snart.me>
To: linux-fsdevel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v2 0/1] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
Date: Wed,  4 Mar 2026 23:16:44 +0900
Message-ID: <20260304141713.533168-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <CAKYAXd_8vG6V0NRT_kb76n_yo+d9vvcx6JZbMARC5+C1ovboqw@mail.gmail.com>
References: <CAKYAXd_8vG6V0NRT_kb76n_yo+d9vvcx6JZbMARC5+C1ovboqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 3/3/26 18:27, Namjae Jeon wrote:
> I am also concerned that this ioctl could expose security data. So,
> could you please resubmit the patch excluding
> EXFAT_IOC_SET_VALID_DATA ?
> Thanks.

Sure.

Expect additional documentation patches in /Documentation and userspace
counterparts and some test units in exfatprogs next week. exfat
definitely deserves its own kernel doc.

David Timber (1):
  exfat: EXFAT_IOC_GET_VALID_DATA ioctl

 fs/exfat/file.c            | 22 ++++++++++++++++++++++
 include/uapi/linux/exfat.h |  4 +++-
 2 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.53.0.1.ga224b40d3f.dirty

