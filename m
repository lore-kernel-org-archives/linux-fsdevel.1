Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.212.254.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497941;
	b=MnPoR7Ag8MiugyV+crM4+LO6Q8QWZ+SQx2QQIiwiUb77aYBcxr4PCWEtYYMKwXcxxft5
	 8AbBTgSnnIxMyRyFrngaXWvs7lhrVkDJSldyCD96zVW5FTYVI2LWFwub1d1i9WJxasV1/
	 m9uHhAGjqv65GhImUqqG3CP4m3uemcyeMK/bUnBlflFU3Yg2DgblZedWPU/9TFArEE47a
	 vV+2PZP8S+688v4vYq3hImNIMVVzjtQvpidbtkgL7EHREhWLcwsVSMqX1V7Kyd8MNWOQ7
	 8xP7d+ACpKrghEie4kSc5a8DVhMnGTpKSpEKETM6h7T2sQXJlG/hjGX3T+sF5P8LyNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497941;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8udlVznDmTmreQTpbodXPVihca5cSx/h/aNayesau9E=;
	b=rnHoGSEzfaaOiPiq6Bl5xTkcN8HnNi4i5uuVxCmvTJPIK5o03G0HVRw4twrdCAfoC/Ah
	 clQGyI5vOfbXC/t7IQkn1M5L9jaTJdIstwwQVm9forX3JvZUDCtMP7H/ROQf0FYfP1kVg
	 cuNtbf5Mt+Oq3mGRVdyGzPRDa+gMeZCvDbMC31BCrQ+q1CK3HwOKLYj0RcNT0KAhzg5hn
	 xI8HqdrtgrbMSkZF8+tewc1EE/ZU5LZ/zrSr2dkX2AcIPilKsbMkBEQhWGw5yUrq1W1GF
	 YXWOG2Z0XBeM9hdnr8DJZP5prhKYXY87Li6y/tNIh/tx3OB770Ih+h/cGaQUZMUB/wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tuxist.de;
	spf=pass smtp.mailfrom=tuxist.de;
	dkim=pass header.d=tuxist.de header.i=@tuxist.de header.a=rsa-sha256 header.s=201705 header.b=QZBF7X6t;
	arc=none smtp.remote-ip=173.212.254.19
Received: from groupware.tuxist.de (groupware.tuxist.de [173.212.254.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A365606A31C;
	Thu, 12 Nov 2026 15:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A365606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tuxist.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxist.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tuxist.de header.i=@tuxist.de header.a=rsa-sha256 header.s=201705 header.b=QZBF7X6t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxist.de; s=201705; h=from:to:subject:date:message-id; bh=8udlVznDmTmreQTpbodXPVihca5cSx/h/aNayesau9E=; b=QZBF7X6tXzDwTVM3svJQvgPvKkQordUMpL58pUIAAvmTUZzJalXlg48lrAl5y9JJ1FuLyMjTV+Ej0nKrSCfFH/d4vdhSSY1GTh9gduwsVmSj7Wz9GNMYa5+4BxXvTfCJyjhouy5m/LJz1L4X0SLn/uZtjYZt+XBzmKXdOLwhpsGuxN8WAqZZLjVGbwYQq6mpUiRf0QuIS9aGKLe3YYC7a9bK226sh9TFm6AunV7FxE8AH3jWWD2Rd66Hmxc9lzE4/IgZyApUy6jJpek6LhjSyfJrkgNJh/bBkqNRKtyfhUnbKmEfvzjvbs5ZCZuI/AkkP5UOGocZWykjA9226Qi/1Q==
Authentication-Results: proxyplus-primary; auth=pass smtp.auth=c0b31cfa-45fd-47d9-942d-1f6e173ca729
X-Virus-Scanned: proxyplus-clamav builtin
Received: from dibsi-vdi.intranet.tuxist.de ([94.31.110.105]) by proxyplus-primary (ProxyPlus) with ESMTPSA; Thu, 12 Nov 2026 15:38:48 +0000
From: Jan Koester <jan.koester@tuxist.de>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	op-tee@lists.trustedfirmware.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] uid_r: convert tun, ivpu and tee
Date: Thu, 12 Nov 2026 16:38:37 +0100
Message-ID: <20261112153841.1661720-1-jan.koester@tuxist.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792552161.git.jan.koester@tuxist.de>
References: <cover.1792552161.git.jan.koester@tuxist.de>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Building the UUID/GUID id RFC (uid_r v2,
<cover.1792552161.git.jan.koester@tuxist.de>) with a distribution
config instead of the one I had tested with turned up three users of
kuid_t/kgid_t it doesn't build with: kuid_t is a tagged union now and
has no .val, and it no longer fits READ_ONCE()/WRITE_ONCE().

1/3 tun: TUNSETOWNER/TUNSETGROUP write the owner and group under RTNL,
    tun_fill_info() may read them without it. Mark that read as
    data_race() instead of READ_ONCE(). Only classic ids from
    make_kuid()/make_kgid() are ever stored there.

2/3 accel/ivpu: the per-user context limits are keyed by
    __kuid_val(). UUID and GUID users share the (uid_t)-1 bucket, which
    only makes the limit stricter for them.

3/3 tee: the TEE_IOCTL_LOGIN_USER client UUID is derived from the
    classic uid. With __kuid_val() alone every UUID or GUID user would
    get the same one and could act as any other such user towards the
    TEE, so those logins are refused with -EPERM, like ublk refuses
    unprivileged devices to them in the series.

These belong into the series before the patch that lets kuid_t and
kgid_t hold a UUID or a GUID and will be folded in there in v3; I'm sending
them now so that the reviewers of these drivers see what uid_r means
for them.

Jan Koester (3):
  tun: read the owner and group without READ_ONCE()
  accel/ivpu: key user limits by __kuid_val()
  tee: refuse user logins of UUID and GUID users

 drivers/accel/ivpu/ivpu_drv.c |  2 +-
 drivers/net/tun.c             |  8 ++++----
 drivers/tee/tee_core.c        | 13 +++++++++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.53.0

