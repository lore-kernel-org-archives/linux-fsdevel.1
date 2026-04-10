Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766E3C9457
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830364; cv=none; b=TZLti8a6/IOrZ8qj3HmzRcEH8696wjhMAML6ffJd1oCnTWVvBO7MnntAegEYS+wFvcjbM9iekWV3nO9/rfABrW2i0yxwvPdSHIcioP2j/dPpzysa91ySAe0nDVNH/besG3dVY9DaqOCz4xHvi5R204KaJQflHT4ZHAxwNyfSBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830364; c=relaxed/simple;
	bh=vhGebzK3MC8BFz2lG3nlwZmqpuDkyeOuW9DcfnB+LrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TlA+AKNDS0wMY8nfLAOqh4T90NYiWyUQnKbNFSf1Gwg+BhsDlPoFwaNgIj0xdEA7wGESDDn7Rj4keM2ExvR3q+ekOhA6Kh3+urBpgr65dC4KR12YmqSJjE9dA8B4NUKKTUW0JCbYG29CEc2SChXTuObyrudXp11vOPadli5lZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9/8Kuf3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9/8Kuf3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso25406225e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775830362; x=1776435162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01EgUuwiW07Sw2KB/0agAz9WjX1rwHu0bO0b6Xpg/5M=;
        b=f9/8Kuf3x4pFQKn1KfD60Wn+XBBIZPD7NNm1Z+kogx/Yu6z2/2366JycxUAwjjpq0E
         H12Uc8RK4dTqT3excecbB51ETNxceS8tuWpHrFy7guQLTBYp1eICeSilgKRk3HnesrvI
         vBE4+XT/BFXRtkQecCwmFRI1j6ca0L3iJgvXmW6zYsVFV6LQCeaQ8hviuOl9cAUTJ3kA
         oFJ0Iuex37SOYJ50XKhxIUH96PUFtmOlG0QEqJQVruoBEwya0+UMy5G8aICqgSVo8Z4X
         BBjJB/Mx47DSlUjh2PdKroj22ZMUY5NLX6vJ6CLNhhIgJnlzR1MzCcYykgS4yBJsL+xQ
         w9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830362; x=1776435162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01EgUuwiW07Sw2KB/0agAz9WjX1rwHu0bO0b6Xpg/5M=;
        b=NBmFFcgVT/81HZTWUZ95f1uVuJzSX3uc8ltGQ9miAYnG1HI3J4gNeBAgn+BYlwQqUN
         gWG4IurbksUrr9EHWWNYINQZFvNr4xvRkKNAd1TBm4CPotNkLE4wg8qAroKwv2li6E4t
         RzrKRtkCUs2WzJlNwtuA6C//COE29fMJUa1VDHPLntd1XQ0sP+zrPZib+npAlvRolmsU
         Ae8EUwiI95DJeCJyxBVV27yp7llEdUsAyTyIgpSqwWLWbZ+tzNC5fuAdNDEUJAj941HB
         zJQvUQwLUp+ihC2IOfqQHONJDdJm4AvGbSDqz/xMmYQ/gJ/C6Kom2I86a1FLKjUHPZQf
         5siQ==
X-Gm-Message-State: AOJu0Yw1BUlOKhIXqfv6sxfbTrFrO67T58FnvnRDZse8TuTCXrsQEU4w
	6uU6t5OnpyKqRJkGgRicZ2wPRZENy1uuDNR5YbL4wwBisbijE6NQRg9p1Hjnhg==
X-Gm-Gg: AeBDietqae0YfJFE9TcAAg9cGCKOqjJ1IHw2qQYIxjF4ArDAI1w7vKjjdFGg4MVcdmi
	bNm8uXytU1GJ9bDABHmd1AjxhiHzt6u1Bx50oa/A8EDyx++suZwstZivPcGafuZcRWQcRw+3I+5
	4dHoCZa1ok4D1Rv2Bw09xRCjTk2rgKd0mHVx7c7e5V1MM1v4YR4gU6tjSJA3hygtZEbBkhHqxLR
	5ek5P0PAp9xj6ELXuCtNzl+zEoN1HLO89y6H1i0Xl5MeGyVbCrzvTbWRh9rNS36t/G/3fiAVH0e
	it/aSwP7NewsrWlXI3KsRlByMRkhw6/T6Y6EdwF0jgxUpRAJ5+H/0AJiT2jL5UXVhhbzpMx+UIT
	wjTg5Nf0KsbL0gZwEe+XKN1zqrlNwoy+5iYzaVV449nrmGkiwgi9pxsMXTDG5ot6tgjlaC3k9pH
	YvWEIZJrooTcXIlxWVjiK9alAKecd+Tg+qHeE7+hasCK3IqRQSUalevIpEkwIu4ym65k6zZ9Scp
	i1iLPGxQaBOEKUEcXIvZw==
X-Received: by 2002:a5d:64c6:0:b0:43c:edaa:f5e7 with SMTP id ffacd0b85a97d-43d64974247mr5093056f8f.14.1775830361368;
        Fri, 10 Apr 2026 07:12:41 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63e46713sm8583226f8f.21.2026.04.10.07.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:12:40 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 0/10] Add support for VUMFAT filesystem
Date: Fri, 10 Apr 2026 15:07:39 +0100
Message-ID: <20260410140738.307546-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Visual Memory Unit (VMU) for a Sega Dreamcast includes a small slab
of flash memory which is formatted with a file allocation table (FAT)
based file system. This patch adds support for that file system in a
hardware independent way (ie you can build and mount a VMUFAT filesystem
on other systems than a Dreamcast).

The code supports the Dreamcast factory settings and other volume sizes.

It is neither mtd nor Dreamcast/SH dependent.

The patch set includes new documentation, modifications to Kconfig, the filesystem code (in inode.c and super.c and the vmufat.h) and adds a new 'magic number' based on the VMUFAT format.

The code has been tested on a Dreamcast (and built with a 32 bit
compiler) and on x86_64.

Tools to format a filesystem are available here: https://github.com/mcmenaminadrian/mkfs.vmufat

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>

---
 Documentation/filesystems/index.rst  |    1 +
 Documentation/filesystems/vmufat.rst |  127 ++++
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/vmufat/Kconfig                    |   14 +
 fs/vmufat/Makefile                   |    7 +
 fs/vmufat/inode.c                    | 1017 ++++++++++++++++++++++++++
 fs/vmufat/super.c                    |  581 +++++++++++++++
 fs/vmufat/vmufat.h                   |  126 ++++
 include/uapi/linux/magic.h           |    1 +
 10 files changed, 1876 insertions(+)
 create mode 100644 Documentation/filesystems/vmufat.rst
 create mode 100644 fs/vmufat/Kconfig
 create mode 100644 fs/vmufat/Makefile
 create mode 100644 fs/vmufat/inode.c
 create mode 100644 fs/vmufat/super.c
 create mode 100644 fs/vmufat/vmufat.h

