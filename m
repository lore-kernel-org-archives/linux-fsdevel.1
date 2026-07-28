Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBA1C28E;
	Tue, 28 Jul 2026 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203001; cv=none; b=PrzKy+U8ZorWbpsrmQl0rnmZdmt+GOjdSSmCPYiygFNRiLGTq4eSR2ODKxQX6Irot3W/7/hzjYhKo44YFDPhtdz3EGf0tAbf5BBKcdYSybgOSWyH0iPE8cdlOYLnuvF3TWsY9rEUF3yfEJF8CxhQZRzlhytK829ZziVmEKclQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203001; c=relaxed/simple;
	bh=HDCyAuxdgVCBrILNvz6FYg6k6wsppd6ilsV2+FeuGgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UX3kPUpK/FRW1cCwwTLQN9J+MuU3eq8Fb6eglI0fCLYNYrGpfNcqR2ThPIr/cQCtArBoDjBFcOD5nbveDNDm/dWppyoufGJy+FV3y9RS/AgIplSm55upEA0kf1Eymb10HBYRhZaewWSEFSviWqoFxMYRjHdcR3GaT+f2P2xP1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DgIbJPwE; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DgIbJPwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785202984;
	bh=HDCyAuxdgVCBrILNvz6FYg6k6wsppd6ilsV2+FeuGgQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DgIbJPwEWEqd3d2/XcdSM2S2bSsenQ/2OhUjS6+GCy/Z2XOW6QYaz6DEhwhg5bdbl
	 DhN3D9tqDi+IDWe3/lrmtWmROc1aLT9sgzfeWqzy9Z/nZwINr9PmjgTTV7Wgvp6WwI
	 3IPxcm3FLWBePoT5bxLywkQrfXOHxuuqYJAsjWoE=
X-QQ-mid: esmtpgz16t1785202969t7e849af0
X-QQ-Originating-IP: +5YvUbHpD6+WySLF/JT2cWo3WLO6xNTvwWwtDPXXle0=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Jul 2026 09:42:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17991540532591921652
EX-QQ-RecipientCnt: 4
From: Yichong Chen <chenyichong@uniontech.com>
To: jack@suse.cz
Cc: chenyichong@uniontech.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: validate directory records in NFS get_parent
Date: Tue, 28 Jul 2026 09:42:47 +0800
Message-Id: <20260728014247.400629-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <h422u6iqz6faysofnomlcqizkqjrsgqw6ooo4jdhfyjuttkqou@p6frlkumlpmd>
References: <h422u6iqz6faysofnomlcqizkqjrsgqw6ooo4jdhfyjuttkqou@p6frlkumlpmd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NDxI9psdf3YVCnVFErG1PL+HMC44OHMzbvi+cjEDN2eHJiTyHwg/Kg7v
	sSiouBt5Cjo1OYcZr3GrNlNIs3sV9rebxDbhNzfQj1lPF9HjdZI2ljqx2lduoZVl6Z6192H
	IQWi9ieFkgNiooWtM0DAnXnhY1Px4w5gMcckRC8BWX3Lk6mhr0MBUjcUv0lXF2IbMPFPzFL
	sAhExgO9OzrRFKC/R54j+WQPoWP/djkq8D7+i9Omv13gu1gcuBxkIqm//RwVg3mpuDTz2li
	5gTDbuMkLJasqedWJ02lR9MrNd5p+7PTFAZ1hmwxHrCDKN5xR7uFo5yjw6dwYnMO2lP+bho
	1c7sByI7lQQeiRXOjp4rSwl6A820+88BTAR6YTOvf6EGbsoMmY32wFeK1FPwpLKDRwsZqgw
	hLauHdeq3wulfEfx/qQzujKsAQcuiYM49QUAI/LWcxo9fVOZtDH9SG6324Vz8tuC2Wayi5f
	9tHz/GYZVkmeClEyFHs2pNCfTgQgDzxMDgEjFOayVRWvjvuzaIPNGim7is6BTuh2ZVVwViH
	AR2EyVu2GfR5aBEU+fdfvA4tEYhVzXjSDxLEMnqiGopM3F+i8d9aV6FtztFHRLX46y4kmky
	prdNCwvH470eI//RHvDqp2i5PdGNTZ3pvBzGKJP5FhjdWCAQfvUArEvJjfeWxLK+lGFUsS+
	5329HR+SS+Liocddi9p6OmzODBFDhmUkNXUjIZgNVrt5bmr6jz5tB45NBdh6Ch5EOXbuPSj
	fTPFuEv2sjYdPVJv6aSsLzynQduYVytKaxscywfTXsPts5hkwYNbvyHLp8ac4z4Mxq1mZjb
	oawiEMoY1NCxrip+QIR7rcZLvKKkwI09qUc82mlwO+AxWQPawjTcmMaIQJqDLXaPS/fwRgj
	q2MPXOMBxw0GjerDMtwg0L/eALsPSC7uWjKebCb88WaEVFNPx1wyBgaaepYLn7nRBfpTo0W
	fsqFa05HPrNfTsYSvTUOpWrk5cJItxO+OW6KEfzieN+93lZIQHpr1gLyY2glToOOuP80=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Thanks for the review. I'll rework it as suggested and send a v2.

Yichong
