Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C25490C18
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587671; cv=none; b=BBdEfS5t95aBM/I0v3jRwUNwZ2cOXnSSphHNIgVj2o5iGpAV3odkfv6hn0SKdHY+R6ay16wq7E+YFGQGIL6JET97IxUnybBv0z6BQsRMUv08Q+aqu0ekvr4XF7qM+1O/P3VMjSihXmz+KBNzYFQXY/gGMZ8WURymsjQKQXxoers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587671; c=relaxed/simple;
	bh=sj6IvvpiH4G5HeXtQ/w8rgZEYm6Vebo2GQ/VGeptjoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zxd/jINhEEeTGwkrD5JfE+NHswrMNWhgFsXeQsJt6WA8I7/X3MZL865Nu8YFsoLA4i0M8wxRzmgI9jx5pyAaGVM1pTKH6deU7SnhSSjpqx9gyifimAFgoFcHg5iPKG8oB1Y/WO1YJuI4YXr6pB3igk5xCBn48PEq0mVAhCtIwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=TLpvnLLE; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="TLpvnLLE"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dbbf409b8so207699866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587664; x=1791192464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OiZ06e1bwcFWfpqrqmzoNBYBcxZ/+ZVmZd6FQIzN/qM=;
        b=TLpvnLLEc4sXSf+c1+e6flJLJdV1JWGsCkJrUOcu9rMp9yd2TsK5x7NmIwJfhBtI5c
         Um+he7cRiHtyWb9I5TeImcCl/mr1w3o0JO0EaX/eAHD9ZyWyS0hj1BLLEJg8Pl7QIuGN
         sJcF+pIW5SXNHl9/6B9nJuIoHwM9M6vY90MlFablsMUY/sp8vqcuwrRQt85OEZxWUxV7
         H4BGD/SYOoBv+T+4ehwx8eUoKCbVQp2h9PuWobrvrwIxCYpfb0KbgTOAvJ+FlWIA1pql
         2QEvphupFFteC1snavDIeRpM0Zs1GE59FR774bzZa3C5nHkzXMCpa0tF378x730EEe17
         NGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587664; x=1791192464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OiZ06e1bwcFWfpqrqmzoNBYBcxZ/+ZVmZd6FQIzN/qM=;
        b=ADNdJYyhEdJjv6eBJq61v3L6N4Ai6Fuagfy6exc47tfdhKjLQe1DKahFJ8XQvsso93
         h/XTunocB4UJEiEQ0VRs7StjKv/0ucLTg/vYJzAcQmfBpHAVHx8MkoLjc42wTAdNu6mN
         0+/b7MfHo1rQvY+RwcT59p9//435v3uFWVqhSrITTnH3bI4EncNwp61w0sIiTAzTpjLX
         eYUejIzYro+TyDCx29ZRU/bB3oOhCerCm/OYbi1AotBZOa+uZfYMOp6x8/AHkS5iSdQO
         rohbAAVrdJOwa9dbjteJsDQIaKYcZ4csZbkbayZ2tKzSEPB2ei2gCorsGGYehoFrANXo
         iz7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxLkl6Tx60Dv7tE0uWuPFYrWNXXITO8l89iaPL/OGtjyxG/UbyMGdB32OmA1nAg6F7EUpS+Z/F5alTRT+kH@vger.kernel.org
X-Gm-Message-State: AFuF++nbY48iPFrTBDWRKHM9AQ+7pldhR1S0Xe4wusk/Wpr2YqQaYVqp
	2+sWyRd9S1HaUNTg1n9ghx1rK7NEL7eYO5IPs1a/X7FqGko5DmRafE67c+08szJa3f+s
X-Gm-Gg: AYBFou3cZpazjxmJP2SuAt4ASFTHRe4B5kfkDBTd2Nt7du2iifwOMCJ7Cv7x7fCX4aL
	6RKwrNRKopX4OBn3fDNr5/wncyTmQxu/mKbvwTZOzj/O3ZrwrJ8B0GBAfTCSr8h0CphnSiV7mEF
	MYhHQv47oqJWwCkwYs0jozPw/V02DHOPbP0BcJvfBjWOx4OHDhwDFeGvGh7rqbQqGGkfb9BqOkh
	6b3MCqgbSW2Tj6g2noHtdZcNoZ/DKRsy6xS/6LkvidbUYvAyzrZ69LUEbYhlfAXTADf/Nbxdaa5
	qZzhK8skiD/K8VgxE75tzDhCKTyTMA6wWE2eF/KOJxMCVujhQlRP/1jYxmqB8w32MMzraRL0eDV
	S7zLd6XuXI4ousRNwPZvVsg4xujNxHFn9ecJsegww9yTj+MFuzjtG22t4oUGt3REsfZkZZAaCE3
	GbYQt8s8RN0BHff4OslhJC50z4+zRPCzA99M7mddw0DVcq3xitl/RkHFW9r8FK4+sE34Ka+1Lup
	4E0aY6r3bpVxGrmGuPlRB6Nv8443IEweeFIr0D7CQ==
X-Received: by 2002:a17:907:6d07:b0:c2d:c17f:205b with SMTP id a640c23a62f3a-c2dc17f4e1cmr359352966b.40.1790587664162;
        Mon, 28 Sep 2026 02:27:44 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:43 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:15 +0200
Subject: [PATCH v3 08/10] selftests/net: SO_PEERPIDFD_THREAD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-8-532018a91b21@amutable.com>
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Add tests for SO_PEERPIDFD_THREAD.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index d73ae9d27a48..cbe53fab44fc 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -36,6 +36,10 @@
 #define SO_PASSPIDFD_THREAD 86
 #endif
 
+#ifndef SO_PEERPIDFD_THREAD
+#define SO_PEERPIDFD_THREAD 87
+#endif
+
 #define CHILD_EXIT_CODE_OK 123
 
 static void child_die()
@@ -1058,4 +1062,97 @@ TEST(scm_pidfd_thread_creds)
 	EXPECT_EQ(msg.ids.pid, msg.thread_info.tgid);
 }
 
+static void *peer_connect_thread(void *arg)
+{
+	struct sock_addr *sa = arg;
+	struct thread_ids ids = {
+		.pid = getpid(),
+		.tid = gettid(),
+	};
+	int fd;
+	char sync;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		return (void *)1;
+
+	if (connect(fd, (struct sockaddr *)&sa->listen_addr, sa->addrlen))
+		return (void *)1;
+
+	if (send(fd, &ids, sizeof(ids), 0) != sizeof(ids))
+		return (void *)1;
+
+	/* stay alive until the server has looked at our pidfd */
+	if (read(fd, &sync, 1) != 1)
+		return (void *)1;
+
+	close(fd);
+	return NULL;
+}
+
+static int peer_pidfd_info(int fd, int optname, struct pidfd_info *info)
+{
+	int pidfd;
+	socklen_t len = sizeof(pidfd);
+
+	if (getsockopt(fd, SOL_SOCKET, optname, &pidfd, &len)) {
+		log_err("getsockopt(SO_PEERPIDFD*)");
+		return -1;
+	}
+
+	info->mask = PIDFD_INFO_PID;
+	if (ioctl(pidfd, PIDFD_GET_INFO, info)) {
+		log_err("ioctl(PIDFD_GET_INFO)");
+		close(pidfd);
+		return -1;
+	}
+
+	close(pidfd);
+	return 0;
+}
+
+/* SO_PEERPIDFD_THREAD returns a pidfd for the peer's connecting thread. */
+TEST(so_peerpidfd_thread)
+{
+	struct sock_addr sa;
+	struct thread_ids ids;
+	struct pidfd_info info;
+	pthread_t thread;
+	void *tret;
+	int server, cfd;
+
+	server = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, server);
+
+	fill_sockaddr(&sa, true);
+	ASSERT_EQ(0, bind(server, (struct sockaddr *)&sa.listen_addr, sa.addrlen));
+	ASSERT_EQ(0, listen(server, 1));
+
+	ASSERT_EQ(0, pthread_create(&thread, NULL, peer_connect_thread, &sa));
+
+	cfd = accept(server, NULL, NULL);
+	ASSERT_LE(0, cfd);
+
+	ASSERT_EQ(sizeof(ids), recv(cfd, &ids, sizeof(ids), MSG_WAITALL));
+	ASSERT_NE(ids.pid, ids.tid);
+
+	/* SO_PEERPIDFD refers to the peer's thread-group. */
+	ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD, &info));
+	EXPECT_EQ(ids.pid, info.pid);
+	EXPECT_EQ(ids.pid, info.tgid);
+
+	/* SO_PEERPIDFD_THREAD refers to the connecting thread. */
+	ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD_THREAD, &info));
+	EXPECT_EQ(ids.tid, info.pid);
+	EXPECT_EQ(ids.pid, info.tgid);
+
+	/* release the connecting thread */
+	ASSERT_EQ(1, write(cfd, "x", 1));
+	ASSERT_EQ(0, pthread_join(thread, &tret));
+	ASSERT_EQ(NULL, tret);
+
+	close(cfd);
+	close(server);
+}
+
 TEST_HARNESS_MAIN

-- 
2.55.0

