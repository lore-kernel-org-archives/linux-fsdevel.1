Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955446;
	b=DXteGIQGGsFz/WaObrtIxvzy12BjY9EjQofrN7ekC8Y53emmG4EBipQepeuzZnMG0WV5
	 69UaAHMtaoyqWncpcYVv2f3YYQYyfQCwbF2NDwuNaVO4dxYz98cO/qUelmJJeU0wUDYSI
	 reKrL40gxaVGw/hqD0xX3jfxMM7YVr3UYyMmXzgXAiY6mLSYXLis0lsOWM4ukt4whjIR/
	 2NgrQnJTtNc1GhcKLjlLkQGeulDmv0m2FqY+MG7tnVUjd0yLXn9xxGUtT1xE9YNKHLBpT
	 QNM8t8RzHRKeoneEQGDoJlxgILTcCh/kLJuAl5s0gkP+hPlcbYe3kXHGEVkkhpA6pdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955446;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=j2JYxmNI3Pz/PpHBBFvUcqB+swfhzDvMni6u+qWbTPE=;
	b=CAaZWbAPJXgrRjIZ0VyBXr7R7o4wW7QlrTKp32SLqnmZfZYzT/ROWiXYBO0GeggWQB8Z
	 7VAthTXLv29985N1lFdVySFv8l/x5ZlsWW0ahrabSQ7gFAVUmK7bY4fG7n6g1oWzD44bz
	 mbhExf9AF2/U0gOFs4toDXC0COSuOSzMKxovJLXkpZVCht8uv8JFPAo4JFVwcf7qJ+0bS
	 uNxEqMhdGxPyRt+TwDfnt7QW2QO5REIbA49byNI0tuCkiCc9ZjyUT7LSB1CoFebFMvs0b
	 CdsHNyk7Sut8jNU3tacwQq7q9CbsFJcaylE2QyZZmagEY4mWs29dNzF05X+eCV+doQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=lsEWSYFo;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AAB606A31A;
	Sun, 25 Oct 2026 19:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37AAB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=lsEWSYFo
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 0B0C91210A2;
	Sun, 25 Oct 2026 16:10:40 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792955440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j2JYxmNI3Pz/PpHBBFvUcqB+swfhzDvMni6u+qWbTPE=;
	b=lsEWSYFoAlpiZ0yicKwNe6MkE3MLVtIIrXQ/RKFh1SP8ZXyG2cq+KLSn1jRK7oHf6ZRi81
	a8LsY8hdoQal3H8iRYX5m8x4oad/cXb7ERixDc7pPm4nK4eTscW4/Q5GSlPhCnnKZPp7Xq
	9AGFXtj/w3mOsVy/3p1ttrcP8OOHA7CX+De8s4h9UHl8UUW9zDKwVSQMoDXuG0qwqt9axY
	tZMZT+hW31wXXdB5UWh8y9CE7HA21g3BexrRg/5AARZwI2vbXsIqnIF1Xz8KNO2b/5106M
	AXmLczIvrEe5j7az8qp5j5zElnrXMphpZkNvcmmKD5hKEOk1FalbwbHA0q9B4A==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 0/2] fat: improve synchronous mount performance
Date: Sun, 25 Oct 2026 16:10:04 -0300
Message-ID: <20261025191006.407209-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
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

This series improves performance on synchronous mounts by batching
FAT mirror writes and improving fat_sync_bhs() submission.
 
The benchmarks were run on top of my other FAT allocation batching
changes currently in linux-next.

Thanks,
Matheus

Matheus Alves de Almeida (2):
  fat: batch synchronous mirror writes
  fat: improve fat_sync_bhs() write submission

 fs/fat/fat.h    |  1 +
 fs/fat/fatent.c | 81 +++++++++++++++++++++++++++++++++++--------------
 fs/fat/misc.c   | 14 ++++++++-
 3 files changed, 72 insertions(+), 24 deletions(-)

-- 
2.43.0

