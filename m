Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929950;
	b=xdVXGILbB1cbJMR1iE12x0ulnTkshZm+L5PdhRcPzQwdypbRqxhapblAe0tdVsslDyGa
	 yBSBbDby1joGpb1fUgAuV6e5ls27YYFr4IxEu9YneVw1dROkR5g/Q3zPbRe7sKc7SBCXT
	 QV6W6cc0mTOFOKe61QnreFhb030qclv2KtcgoXHC8fcywmgglrsCscjhazwL5u4sROy3n
	 5SLy3nAoxcD8PkUnLFValQM/Zycw2uVEthuWibhsCZ0C1PgyUj5F28PoftPfvvY1nVuME
	 Vaq/6qFB8W9EmZbC461B13JjC/PK6ojVbGuqnnhsuJoljPDgUz6DsqzFSOO1zBSomSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3bd1KiA0pB2vbrGDlNRlcrXdbbR50j7O7RMZuib5bX8=;
	b=ZEmFyp/jG4nIoXQfVSlxTS9W992VmDf8cLw/du0WXDwdQ6xraTVI1DrnhShvWEdwOQx2
	 AjJVEFI8GEGpXaAw1N8MW+z5vrNY7aDe3/4VmcHGDGpwWNfSxbbHEWB5Ieoj02oPq+u/P
	 VkzPjgAn+MCQXcRfykS+VN4u+gsed0YFEFSm6njjoZ8r5YXOxPEzqqreYi3CrjUg+4xyK
	 T6dZtVo+SyJKTgBETUPzFgzPpVd4sIxyagJU8RyLEpItxfmV+vPQIpErIH55TcUYlsLYq
	 w6C0gtSWQgCSq2V8KpxUZNKa+Jap8fNrCmnMZtwDaApp/VAqNftjDx044F1IovMYb/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRfGw593;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6342606A31B;
	Fri,  6 Nov 2026 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRfGw593
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0AD1F0089F;
	Fri,  6 Nov 2026 01:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929949;
	bh=3bd1KiA0pB2vbrGDlNRlcrXdbbR50j7O7RMZuib5bX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WRfGw593EM7T7lIMrOfsUn0/yD0X4yHccFfOojvCKgpzNVXetokkE7YRCkdjYt9v8
	 pi/3RtQ+6VeXG+5UPedy8rt89CzJ20yzV94ZRukYsXUa7/W6HWw2vRo5t9zrNKQNkl
	 028Bx7I5cobgAxwuPb7HmX4Q+hxXpZZYK33xLlaWATGuoDJy0aEJL0iHC/aRW0XFLe
	 fvzOeI/5waeRZzQ1h9u1FHTdyTRrrvGzXQeTbhCWMaJ7q1GUF1xUrF8cQ0m8U1Mx3t
	 YNw+IqHBGfP2gROvKdyA9eLrpnQuLI2arKHOszsQm1Jvmddm2aaWrKXUfWu/UpSVRz
	 w165EjytChetw==
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: add namespaces to TARGETS
Date: Thu,  5 Nov 2026 20:52:27 -0500
Message-ID: <20261106015227.3718251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105-burggraben-wegrand-seeufer-18d3c8517fef@brauner>
References: <20261103165419.687806-1-sashal@kernel.org> <20261103165419.687806-4-sashal@kernel.org> <20261105-burggraben-wegrand-seeufer-18d3c8517fef@brauner>
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

The namespaces tests are not in TARGETS, so "make kselftest" and the CI
systems that use the top-level Makefile never build or run them. Add
them.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Tested on vfs-7.5.misc with gcc 16 and clang 21 on x86_64: all 13
tests pass in a VM with the namespaces config fragment, and they also
build for i386 and arm64.

 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 07c3719f8b04b..f8fb771d3b0e8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -85,6 +85,7 @@ TARGETS += mount_setattr
 TARGETS += move_mount_set_group
 TARGETS += mqueue
 TARGETS += mseal_system_mappings
+TARGETS += namespaces
 TARGETS += nci
 TARGETS += net
 TARGETS += net/af_unix

base-commit: 8f92edb375bc5b54b211686231d489912a91b32a
-- 
2.53.0

