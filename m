Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B493815ED
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780741585; cv=none; b=acR7nMB8X1UwXrz1efTxUb5Fjpps0LT+HCgKs7ZlLRAYWpOIjus2gAFjvmixe+BnFt9Q01Hgs/82q+j/KM33Q1a1eMfFJIIso8XLlSs5oz+mBOHg2clIVRuGbyJfxRNnOIcaVuHJI+hzZlHSoMvvA/cXuZNO/UZNxV6bzpn56r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780741585; c=relaxed/simple;
	bh=pvXHi3ta4wO2EOw3QAhPaAH8c0r+9f6hbzLuXLNshok=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iOvK5gjtEphz5WP5SSTY4H7k0alzeBWJJnDd85fH5ZRKS4XyCfx3VfKcG1lkSBubgbFiBKDtawtBiBhhQ9rlFcnZnE/u/1YfUK2jsLDGgS2PB5KML5wrybZS3SjotL+3eW63h/73XHO85Ik/wtwLhUBcpt8VrPbNBJ2xYY1kplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZqEhVIqa; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZqEhVIqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780741572; x=1781000772;
	bh=mBmeMh/kwa5Ri4KCTTimk4svEA/2Fb5nXcUXUl5S9dY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZqEhVIqav6CJD/KImYyrbFN3s+1/2fDxC5PJMaGXqVPtJcFN3GkGqIrhRyphN1ZvH
	 TQQq4CihDPcgSplDrm99Pd9PAe5nwjOnEipV1aUYzrPnf6zZAKp2TLa4SdZTpxBkMn
	 chS+fBXVmJyQdgY1cBJh+ImK0peO7qDFZ6zkrDyNJCroIcrfHYWBXo8+Po8tu2d2YP
	 iO3ISzopkkb+/mJ4cPAbxDtZLQ/UFW1cIVN6M7nPCyULuQ0+2YVVSxxdtE7Nf/VHUM
	 wo7I5apyUdCaJwBBr6kXWijbqYKHHN/XHAUs7lVslgseyoKYZiwPdFW3oCe5QhcVnO
	 OLH4oqvrV/o4A==
Date: Sat, 06 Jun 2026 10:26:10 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: fix u16 truncation of restart-area length check
Message-ID: <20260606102606.74510-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: ea8970d85ef9923f6e4daa4dbda35a2044920e21
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ntfs_check_restart_area() validates that the $LogFile restart area and
its trailing log client record array fit within the system page size:

=09u16 ra_ofs, ra_len, ca_ofs;
=09...
=09ra_len =3D ca_ofs + le16_to_cpu(ra->log_clients) *
=09=09=09sizeof(struct log_client_record);
=09if (ra_ofs + ra_len > le32_to_cpu(rp->system_page_size) || ...)
=09=09return false;

ra_len is u16, but the right-hand side is computed in size_t
(sizeof(struct log_client_record) =3D=3D 160). Both ca_ofs and log_clients
come straight from the on-disk restart area. With an on-disk
log_clients of 410 the product 410 * 160 =3D 65600; adding ca_ofs and
storing into the u16 ra_len truncates modulo 65536 (e.g. ca_ofs 64
gives ra_len 128), so the "fits in the page" check passes even though
the client array described by log_clients extends far beyond the page.

ntfs_check_log_client_array() then walks the array bounded only by the
on-disk log_clients count:

=09cr =3D ca + idx;
=09if (cr->prev_client !=3D LOGFILE_NO_CLIENT) ...

For log_clients 410 it dereferences records up to ca + 409 * 160,
~64 KiB past the kvzalloc(system_page_size) restart-page buffer -- an
out-of-bounds read of attacker-controlled extent, reachable when a
crafted NTFS image is mounted (load_and_check_logfile() at mount time).
This is the in-kernel analogue of CVE-2022-30789, fixed in the ntfs-3g
userspace driver but never in this revived classic driver.

Compute the restart-area length in a u32 so the existing bounds check
rejects an over-large client array instead of being defeated by the
truncation.

Fixes: 1e9ea7e04472 ("Revert \"fs: Remove NTFS classic\"")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reproduced on a KASAN build (in-kernel ntfs, fresh-boot slab) by
mounting a crafted image whose $LogFile restart area sets
log_clients=3D410 (ra_len truncates to a value that passes the
system-page-size check):

  BUG: KASAN: slab-out-of-bounds in ntfs_check_logfile+0x1e52/0x2460 [ntfs]
  Read of size 2 ... by task mount
    (cr->prev_client, with ntfs_check_log_client_array() inlined)
    ntfs_fill_super -> ntfs_iget -> ntfs_check_logfile
  Allocated by task ...: __kasan_kmalloc -- the kvzalloc(system_page_size)
  restart-page buffer (the OOB read lands at buffer_base + system_page_size=
)

With this patch the same image is rejected by the existing
ntfs_check_restart_area() bound (ra_len is no longer truncated), so
ntfs_check_log_client_array() is never reached, no OOB access occurs,
and the mount fails over to read-only. A clean image is unaffected.
Full A/B logs available on request.

 fs/ntfs/logfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -132,7 +132,8 @@ static bool ntfs_check_restart_area(struct inode *vi, s=
truct restart_page_header *rp)
 {
 =09u64 file_size;
 =09struct restart_area *ra;
-=09u16 ra_ofs, ra_len, ca_ofs;
+=09u16 ra_ofs, ca_ofs;
+=09u32 ra_len;
 =09u8 fs_bits;

 =09ntfs_debug("Entering.");
--
2.43.0

