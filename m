Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143EE31F989;
	Thu,  8 Oct 2026 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425432; cv=none; b=E+PC6xg2pbjrIobrtAWTNm3wiVONELLDRedJ4gBZ9AUi0cno6/oEuLgOfiIryHXLmDSHO2vjthiZUhWHndMY8BRqA3pOx0GpGaRYSGN1cYfoXIBBDAkBoMBEAZE5iNw7jCde9c+Ytv3nKVt/RWYvcydTPSkQsq5RBUoshEroIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425432; c=relaxed/simple;
	bh=MbSfLuKAe2MXv6QwbO9fkmt1kWkPiokIv4ar8ssIYN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlOhArnPvxZOEG1ZO85zGkbqAGZoWkc2PNskMplHOH0r9WEuETXox9czmm0yQnRFY0jc0KLFA5A+bEPjuWn5ooPKifs8OMCec7OT8/Q9iE1gWVu6fuQniYP5hPLA5tpS6GepQku3s/UuQSAfgAAHyyDcKa0mabASoYk0Hk5MWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=mxRIqx9Q; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="mxRIqx9Q"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 612051210F1;
	Wed,  7 Oct 2026 23:10:17 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791425419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0wUgLvTVsMGcJNSSKNSuD9zDyOwA/45mp5d5MCPf6sY=;
	b=mxRIqx9QoX7nZtDkWLon8Z8Ga9np02LqjR+lD3gK4F1EENE5W80yJZYxVgaFUfiJLzaK74
	ELYdPu4dWUv9tiOD4H0OPrSpSfbH9S3cXcrrzPInxJTVDq2O6LVVpZMr5JHfUgpqhv76O1
	P4l8zsu9yZfsB+aMiv5BdgWDE5qJvcgWTYZ3OLv+pNvoc2VZsrkZKkG1HYtsJkqeolA6i+
	A30QhFYnfO6ckTIkqkoZc9x4SkGhcdg+/anSDUwNO3YpvwruO5Q2G2UPmpO7WaqtIuzr+Z
	wDmrs4jdm88tVWZIr3frhPJRZjrnwE59duEkL/4XC1EQ8jC8CejlZ3/62pVHkA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 0/4] fat: allocate multiple clusters in fallocate
Date: Wed,  7 Oct 2026 23:09:36 -0300
Message-ID: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds support for allocating multiple clusters in a single
fat_add_clusters() call in fat_fallocate().

The multi-cluster TODO in inode.c is not implemented, as doing so would
require speculative preallocation or an iomap conversion.

Matheus Alves de Almeida (4):
  fat: remove cluster allocation size limit
  fat: return only first cluster when allocating
  fat: support adding multiple clusters
  fat: allocate multiple clusters in fallocate

 fs/fat/dir.c    | 20 +++++++++++++++-
 fs/fat/fat.h    |  4 ++--
 fs/fat/fatent.c | 61 ++++++++++++++++++++++++++++++++-----------------
 fs/fat/file.c   | 10 ++++----
 fs/fat/inode.c  |  8 +++----
 5 files changed, 69 insertions(+), 34 deletions(-)

-- 
2.43.0

