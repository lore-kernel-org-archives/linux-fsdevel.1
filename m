Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929168;
	b=B2JqM+nsVJvqu9cw5Waqsu4RwH0muhT2F0keheTN/tZgjYygM98XHxHF+jllnYrOczxC
	 R3gdaDwp7/IBwVfj4uylJgXRAjZG3LfJo5UoKvrqghbXT/6Da9hpm60HB2YE7Wh7IZbcd
	 PWbOhRma9zl48NY6Xm3nphhkNfwmbqS/x3LOZmIPQIEnmGBe3KsWxbtiIdUBN/ieRnJre
	 663UNm5CPclk+mUNqBcGNBGAmWy64F+9GWgWurbAHQTIQZKLC/zRX/WcOQZurR+mSysC3
	 n0OQXyJuWh0I3O+PcG4mQo/kH1g7PkbTV2GZGpGwfSPi3ZqTCpluQL+M2zDYBZsyoSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929168;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HjNUQY5wJGY+yQbPK/40OwNZCuiDHKKrj8gStUJAzZ4=;
	b=xe9HauzyWNMJIU5mig/bfjXB0fv7fJUIMiFtVNRl6Vtqdf3YLYI6Bp7sig/lt6Dmj+un
	 3Gmv4LhKzIKxDXCXu+cugsAddLgaFarZ8g/ZHrsq+K4RkWzo0LOzWFkNggjggSwfuWJRX
	 f1CjrwgCAlDNC+kqwiFd272Uzuxn7O5akTZWC2JQPOwWnqIxFfRKonYCjdD3YUyfqoytK
	 f/o1Nuvj0ZHg7N10j58uCbYtCWZ6UEmC671OQ1argseeRDTw0eEPzJk+jNwm3cESldeof
	 CflbZUUP8kxheLOOAjeF0zm1XHN3Jqr4FvWO38I8eoXSwn4K1EdoxeJY3vlDVklxpzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iv0daWHi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7A606A32A;
	Tue, 17 Nov 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iv0daWHi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354E21F000C5;
	Tue, 17 Nov 2026 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929168;
	bh=HjNUQY5wJGY+yQbPK/40OwNZCuiDHKKrj8gStUJAzZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Iv0daWHitVDEEurx0HisuhoiO01uIPBP4qjg2sNNQmV2SB89emeIkM1A+C7QLf0OS
	 7pOwe5i310pVj1pLfRe0S8wwjnYXuP30WK21yUUu7GmZcD1Ll0pWFfQpqG/ZF6T2IQ
	 UFEmijzSVV61VY8cR0YPcYT1ghsGIj60zC+YhfcCMrNpfE+EbqkhV2Ot9a9qE2Lhb2
	 gdtWMnKrUBOLcfxjM1IdTtEdfm+FppGn+yP3JDUcvGMOjfzYq4zAypUSHe0YkGsHfi
	 DG7+reUa3GKS5WZFE0seZyRGZhDcfTBiqIfC/q37fP7WsKJdFpcHMhAHofBHr8NplW
	 yjd095qBnXU8w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Nov 2026 16:25:31 +0100
Subject: [PATCH net 2/2] selftests/net: check that a short SO_PEERPIDFD
 optlen fails
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-work-net-peerpidfd_short_optlen-v1-2-a93f56288501@kernel.org>
References: <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
In-Reply-To: <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TYh8HFgL2PecpXrVoV14t0VinycFc9TIzdqgeJ3yKOQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9KWLt2rK/ZitPn7vZhW9Vb5ZPbpSYrPFE0l+oIaG1g
 PvV5/KcjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImUrGRk2JbItdnz29vorrTt
 mk0NTjeW1956wLo054BYl57Gyi1feBj+pyqZt03euT13o/vrJ3M+Wn75+Pn17brFe1QPJU18luK
 iwQsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Cover SO_PEERPIDFD and SO_PEERPIDFD_THREAD with an optlen of 0 to 3:

- getsockopt() fails with EINVAL
- optlen and the buffer stay untouched
- no pidfd is installed in the file descriptor table

Check that a full-sized buffer still gets a pidfd.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 51 +++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index cbe53fab44fc5..c26f055a19032 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -1155,4 +1155,55 @@ TEST(so_peerpidfd_thread)
 	close(server);
 }
 
+/* The lowest free file descriptor, where the next pidfd would land. */
+static int lowest_free_fd(int fd)
+{
+	int nfd;
+
+	nfd = dup(fd);
+	if (nfd >= 0)
+		close(nfd);
+	return nfd;
+}
+
+/* A short optlen must fail without installing a pidfd. */
+TEST(so_peerpidfd_short_optlen)
+{
+	const int optnames[] = { SO_PEERPIDFD, SO_PEERPIDFD_THREAD };
+	int sv[2], i, free_fd, pidfd;
+	socklen_t len, optlen;
+
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM, 0, sv));
+
+	for (i = 0; i < ARRAY_SIZE(optnames); i++) {
+		for (len = 0; len < sizeof(pidfd); len++) {
+			free_fd = lowest_free_fd(sv[0]);
+			ASSERT_LE(0, free_fd);
+
+			pidfd = -1;
+			optlen = len;
+			ASSERT_EQ(-1, getsockopt(sv[0], SOL_SOCKET, optnames[i],
+						 &pidfd, &optlen));
+			ASSERT_EQ(EINVAL, errno);
+			EXPECT_EQ(len, optlen);
+			EXPECT_EQ(-1, pidfd);
+
+			/* No pidfd was installed behind our back. */
+			ASSERT_EQ(free_fd, lowest_free_fd(sv[0]));
+		}
+
+		/* A full-sized buffer still gets the pidfd. */
+		free_fd = lowest_free_fd(sv[0]);
+		optlen = sizeof(pidfd);
+		ASSERT_EQ(0, getsockopt(sv[0], SOL_SOCKET, optnames[i],
+					&pidfd, &optlen));
+		EXPECT_EQ(sizeof(pidfd), optlen);
+		EXPECT_EQ(free_fd, pidfd);
+		close(pidfd);
+	}
+
+	close(sv[0]);
+	close(sv[1]);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0

