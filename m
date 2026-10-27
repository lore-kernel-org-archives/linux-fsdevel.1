Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793131731;
	b=VfJuW2fDJ36cd5/PhP47v0nphxiJrObGdMN5Mg5Cq1rUorlV0FW/7Oz+Lljmxg8IWQQa
	 Mrz8QP8PJw3rsZZYxjd40KIm8F9iA6jyw2NbkK5sRXZMu5tIApn6vgGYv4k3b4qhJ9WWE
	 i37RiRCYvyHcc7luq29uEt55VAoFKrn72fyWOQadW0Q+zr+57br0xHMaDpUCsmzdSJMdH
	 Hj71LVGmmjQa+fhsZW+Jg0rvVtE8+MvGv622DkRTZxqL+pv6uYGm0IQ6O4ORaI0Bp9scS
	 8LPinY5a/ndS5+eU/UhkFHe/VEIhSKnG41ZbNyKz3w4S70JGS+G5ceBHy1ulCHECYMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131731;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/mHTzY5Ons10P2yx+EMererndbZ2K+UGy2iG7swLLJ8=;
	b=uHMBpgQ3//COjXPmDAwgUNSXns7W6Gq2p1yx0i42PF9WWXhmUSZGBF7E2XpZfp/Lq3Zh
	 Dvj446sy6IsEj8AhZXslgblIOwKfl4xVIix2BCiFEpSld8za6gFvHBWkqbo1l8PRdAHN3
	 QzeHC2utZP064CTLtM2wAcuMhdarmskGR0vNQ/HO181hMUBHsl9FOsOwnFV91ipBwYd1o
	 Ybxu+sWocXqT0xQtgsE2+EqoBfkFrF78vMy3lbaw8n1Or6hm6u9A8964fPJ88qcm+OSTt
	 5hUnQ1MLtpAklA7UeR2zReXCbNwqkGF20MnIlTO8ZyjyYWIwwtWMWIFxDvKDfkLItiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiAyQVOk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F95606A31A;
	Tue, 27 Oct 2026 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiAyQVOk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793131730;
	b=RBGksrlD3FmQvkQaQZjOjRKAZ2/UrOHDVZiUoJKXbIGjwsmwIJ5CHGnQxRVpUySNhxAP
	 PIcFSP1LzdWi9UxSTICLfbzdSUqUoi0kCCtcNEj11W0M4hMRVwVUGQnHB2Y6XqrpVA+9x
	 msSCQQ9hwZOw7RW+e0MZf6GBRRE18Wj3FkZ21TSO1vrVcqM80mGJD8d3CotK9nm4RMyLN
	 UNRgPqDFQ1faibtpemouk2S2Eh1S80WAdQ12lWuQXCyxWuDyefuZkaz3pNFRaygdBMzUm
	 FLOsDm6GCyuc2XYbxO7B8tcXGHZu5EN2gI5AsvXL0g7zs5b78+0dl2mg4fpE7qZrJvw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793131730;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/mHTzY5Ons10P2yx+EMererndbZ2K+UGy2iG7swLLJ8=;
	b=mB2EAIvvRqWDwHRtWd1hmrSllDp6b7n5dECNgz6zn2S7aJvdZk6vSZKy9+d1z0ELZnL+
	 UbXzmxo4xlBdq3+1Gd0F+rWNiNwOghW9qlSeXEVshpTMDKkqX/o+g0aJz2kd/TWXIULxY
	 hfx1QWiKYTSQBTcbYImHpyLeos97b3C0JUn8mp7Wg9E+JU0deJlkgIF3CRgn5m474GKAr
	 1iHEnTfaICLUN6u2UbAgyKXMzLZUNk2sSV39AlgmjsGjZbWFs5AJJbSDUk+hw2GQKMqQW
	 XScjFg04kZAzca9sXJbfbFCBiS25S36Jeirk3QhCAxmElscq5kW/G//kzpQ9IFjPhVg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 44F7B1F01825;
	Tue, 27 Oct 2026 20:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793131730;
	bh=/mHTzY5Ons10P2yx+EMererndbZ2K+UGy2iG7swLLJ8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=OiAyQVOkLCCq9kk+tFVsn4imSjzbp1fplAMIAnJrIsH8IhH2EF0ja0MFt5eBRBb9G
	 SDj7Ok45L6qpCqLweNS+ySendxyEyEIbyPHdX8WxpVRtU/yk6AA2TLZIdJFpox2WLn
	 Cw0lXIc+8YZas5sc93u+zu5Gbo1Ryuoxll7XUDQ+leYQkHsTcjJ1UBZJ6GLQWY4/KF
	 1GPOrpqffe4zrqQsWlIx0etIp5Y0bdAGmqgJ9y0nJm0XNJgjmJODCToQ2umphe+B/H
	 Wvcit4yLMfYCSMu5u/vpaZgDUn3c1EFJu2gHlzp42naz6BIfGIXN95sYRTDWSZk1Gg
	 9VwMLUaPMQ6Iw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 946E4451DD;
	Tue, 27 Oct 2026 20:08:49 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Tue, 27 Oct 2026 16:08:49 -0400
Subject: [PATCH] fs: annotate data race in get_nr_inodes()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-kcsan-inode-v1-1-1ef0eb871f2c@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDWpohJXEYtqB0NS0kEk4u6K5
 Vv8fwFjIGSokwsCHsS0+IgsTcCOxg8oyEWDkkpnUlVitmy8IL84FMaVWklduDLvIRZrwJ7O79a
 0v3nvJrTbu4D7fgBSSeuJbwAAAA==
X-Change-ID: 20261027-kcsan-inode-ad562064d53f
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793131729; l=1338;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=RilFwEuG5mfa59o4kBWEQvpFFOo3It83HXyNfvM2YrM=;
 b=Ti0XKvyXUR4c9cFr6dRTkQZpL8+CKuInzahtgyklAh0OzNzygLqhQf2XBwxBBk6byk6QhRx4Y
 k8raP+nEciCAs2J/zhHdg+HrqiMd7dtXchK4ZPvnP/wL8IW74E4NRX7
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

get_nr_inodes() sums the per-CPU inode counts without a lock, and the
result is only an estimate, so it's harmless if one of them changes
during the sum.  Wrap the reads in data_race() to mark this.

  [   11.857490] BUG: KCSAN: data-race in get_nr_inodes+0x9f/0xf0

  [   11.857568] race at unknown origin, with read to 0xff1100002b6281e8 of 8 bytes by task 106 on cpu 1:
  [   11.857621]  get_nr_inodes+0x9f/0xf0
  [   11.857675]  get_nr_dirty_inodes+0x1d/0x110
  [   11.857748]  writeback_inodes_sb+0x3d/0x60
  ...

  [   11.870052] value changed: 0x00000000000000b3 -> 0x00000000000000b5

Found with KCSAN while fuzzing under a deterministic hypervisor that's
currently under development.

Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1cb6293b237a..ee4366264c36 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -79,7 +79,7 @@ static long get_nr_inodes(void)
 	int i;
 	long sum = 0;
 	for_each_possible_cpu(i)
-		sum += per_cpu(nr_inodes, i);
+		sum += data_race(per_cpu(nr_inodes, i));
 	return sum < 0 ? 0 : sum;
 }
 

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261027-kcsan-inode-ad562064d53f

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


